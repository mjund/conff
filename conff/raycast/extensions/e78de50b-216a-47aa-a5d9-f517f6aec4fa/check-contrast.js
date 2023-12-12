"use strict";var J=Object.create;var l=Object.defineProperty;var k=Object.getOwnPropertyDescriptor;var x=Object.getOwnPropertyNames;var O=Object.getPrototypeOf,I=Object.prototype.hasOwnProperty;var U=(r,e)=>()=>(e||r((e={exports:{}}).exports,e),e.exports),$=(r,e)=>{for(var t in e)l(r,t,{get:e[t],enumerable:!0})},y=(r,e,t,n)=>{if(e&&typeof e=="object"||typeof e=="function")for(let a of x(e))!I.call(r,a)&&a!==t&&l(r,a,{get:()=>e[a],enumerable:!(n=k(e,a))||n.enumerable});return r};var q=(r,e,t)=>(t=r!=null?J(O(r)):{},y(e||!r||!r.__esModule?l(t,"default",{value:r,enumerable:!0}):t,r)),M=r=>y(l({},"__esModule",{value:!0}),r);var b=U(c=>{"use strict";var d=c&&c.__assign||function(){return d=Object.assign||function(r){for(var e,t=1,n=arguments.length;t<n;t++){e=arguments[t];for(var a in e)Object.prototype.hasOwnProperty.call(e,a)&&(r[a]=e[a])}return r},d.apply(this,arguments)},T=c&&c.__importStar||function(r){if(r&&r.__esModule)return r;var e={};if(r!=null)for(var t in r)Object.hasOwnProperty.call(r,t)&&(e[t]=r[t]);return e.default=r,e};Object.defineProperty(c,"__esModule",{value:!0});var E=T(require("child_process"));function S(r){return Array.isArray(r)&&Object.prototype.hasOwnProperty.call(r,"raw")}function F(r,e){for(var t="",n=r.length,a=0;a<n;a++){var o=a<n-1?e[a]:"";t+=r[a]+o}return t.trim()}function g(r,e,t){return t===void 0&&(t={}),process.platform!=="darwin"?Promise.reject(new Error("osascript-tag requires macOS")):new Promise(function(n,a){var o=t.argv||[],f=[],p=F(r,e),h="AppleScript";t.language==="JavaScript"&&(h=t.language,p="(function(...argv){"+p+"})("+o.map(function(u){return JSON.stringify(u)})+")"),t.parse&&(f=["-s","s"]),typeof t.flags=="string"&&(f=["-s",t.flags]);var i=E.spawn("osascript",["-l",h].concat(f,["-e",p])),m="";i.stderr.on("data",function(u){m+=u.toString()});var v="";i.stdout.on("data",function(u){v+=u.toString()}),i.on("close",function(){if(m)a(m);else{var u=v;if(t.parse)try{u=JSON.parse(v)}catch(j){a(j)}n(u)}}),i.on("error",function(u){a(u)})})}function w(r){for(var e=[],t=1;t<arguments.length;t++)e[t-1]=arguments[t];return S(r)?g(r,e,{}):function(n){for(var a=[],o=1;o<arguments.length;o++)a[o-1]=arguments[o];return g(n,a,r)}}function A(r){for(var e=[],t=1;t<arguments.length;t++)e[t-1]=arguments[t];return S(r)?g(r,e,{language:"JavaScript"}):function(n){for(var a=[],o=1;o<arguments.length;o++)a[o-1]=arguments[o];return g(n,a,d({language:"JavaScript"},r))}}w.jxa=A;c.jxa=A;c.default=w});var W={};$(W,{default:()=>P});module.exports=M(W);var s=require("@raycast/api"),N=q(b());async function R(){return(await(0,s.getApplications)()).some(({bundleId:e})=>e==="com.IdeaPunch.ColorSlurp")}async function C(r){if(await R())await(0,s.closeMainWindow)(),await(0,s.open)(r);else{await(0,s.showToast)({style:s.Toast.Style.Failure,title:"ColorSlurp isn't installed",message:"You can download it from the website or the app store",primaryAction:{title:"Open Website",onAction:()=>(0,s.open)("https://colorslurp.com?utm_source=raycast")},secondaryAction:{title:"Open App Store",onAction:()=>(0,s.open)("https://apps.apple.com/us/app/colorslurp/id1287239339#?platform=mac")}});return}}async function P(r){let e=r.arguments,t="";e.foreground&&(t+=`foreground=${encodeURIComponent(e.foreground)}&`),e.background&&(t+=`background=${encodeURIComponent(e.background)}`),await C(`colorslurp://x-callback-url/show-contrast?${t}`)}0&&(module.exports={});