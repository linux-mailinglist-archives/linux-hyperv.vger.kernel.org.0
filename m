Return-Path: <linux-hyperv+bounces-8233-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8B8D1560A
	for <lists+linux-hyperv@lfdr.de>; Mon, 12 Jan 2026 22:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63C04302F2D0
	for <lists+linux-hyperv@lfdr.de>; Mon, 12 Jan 2026 21:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7773335544;
	Mon, 12 Jan 2026 21:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="jHPwwCtf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11021082.outbound.protection.outlook.com [40.107.208.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE5730F54A;
	Mon, 12 Jan 2026 21:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768251723; cv=fail; b=k9ltwnUaS7VyIHiA6CCah/T9lRsLyw8+PtwATkCS6zMGJmwMFZmeEvEVMTBwhT9Ec8rcmK699ykJtHOPDpWa7WmXZAC0zoNGgKKAWKA5lYIvTXkW6GCjvGtwERNvHc47ayz6NbPuxDJU2haijcUnmnoQSISCYj0X/Ph+NYlYyJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768251723; c=relaxed/simple;
	bh=fkqpWlOY5Rm0V4WjmA4jhllyyz0NgnY2Jx3e84znc00=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=umKvX3X0Tc+XzfIZrlzSSCbm1WJSjeiUK8bifRYu0H+kXZ0aGR88auguPf7jq+tTX1NAQqMIlB6mm7Gv4P1KSVwlAeFzUCSWDjwbAj+Qgmpw8EC+OqGqzlewDurLk6Q759zA9PZ6o0dso3HNcS8TgN7YNlaSh5w3SGDNgLDlN0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=jHPwwCtf; arc=fail smtp.client-ip=40.107.208.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ehNQwA7WzjxHcYbCyPG5LpzgHQ6DlRVQ/oy0KxCumMI/Obh9UQcuwDoeBxaxKQMQMbj7botBra9nw+VeHCfEMh8twoe+/04xrtQbvjRqhvQp2oBIF4NqOMitlN7tly5tHc3aZr83zzVZ00cj9nQGdiKRnl+oduLe8PVQTqiidXqxG9M9ZSesKPdogfAICQKlMTstmH1Sp7kP7Jb7gHUYPg1gXp2tfF8h0SBD6dS8TvXsNc78txO7jNoZ1BgbTKpc98rBVZDv6+I3PTPXp4T7wEGLpoUy3wtKRMIXMWycSTPcPiIoAA2yUdwISMzhto56wJ1pSQNDtSB8BUuzFQC2IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6SmnMGqdl9VoLcUAqXMzM2QCPe/4x2aTFGYtxUQC7+Y=;
 b=BAF3/mg39JVSs46aOXJQcGej3Sda7d21C6X349G8nOwTqR8qrSXKUlhoAtiIQ+uKK+0siH1iGnlXqV9umZWeZ6hS/juQ5NOv6cv8o0y/r4ia0ZMhY+2tm9WKQxp51AekZ2lyrgC6rFfmox/70eOJrloFDIzP8OByVBm+3B/F+JaSUYqTs5/NuYnc+Axk8QYiG3G+vmPY8YPu1rBqy7F058VS2ff2rXRh9XFmh4MR1icEM7HVmPk9fb1kxxWZx6/Q4KwBzfkkXROteCjRkDa163D0SPDMotBJcDstmtDGsnWJQz5Y+rZEdGSGT0nbSJ5aICNiwHv38O3C9enTGX0UEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6SmnMGqdl9VoLcUAqXMzM2QCPe/4x2aTFGYtxUQC7+Y=;
 b=jHPwwCtf4Xs5SRbNxPG3/DXT72ST7uhn54JTTiPQW4CdROYyrvCZlsiNQ9oF4GAKsPk9FJDrGOaoBAU5CHs8FT/TNGvWk/3hoYlhwcU15PeX0ZBP8Y1+4WCjonQmB8AMKEyOLdV0wIztFV8mEjpRf0TpVPOWRzS66/61BpefHVs=
Received: from SA3PR21MB3867.namprd21.prod.outlook.com (2603:10b6:806:2fc::15)
 by SA1PR21MB6034.namprd21.prod.outlook.com (2603:10b6:806:4af::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.1; Mon, 12 Jan
 2026 21:01:59 +0000
Received: from SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3]) by SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3%6]) with mapi id 15.20.9520.001; Mon, 12 Jan 2026
 21:01:59 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>, Haiyang Zhang
	<haiyangz@linux.microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, KY Srinivasan
	<kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<DECUI@microsoft.com>, Long Li <longli@microsoft.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Konstantin
 Taranov <kotaranov@microsoft.com>, Simon Horman <horms@kernel.org>, Erni Sri
 Satya Vennela <ernis@linux.microsoft.com>, Shradha Gupta
	<shradhagupta@linux.microsoft.com>, Saurabh Sengar
	<ssengar@linux.microsoft.com>, Aditya Garg <gargaditya@linux.microsoft.com>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>, Shiraz Saleem
	<shirazsaleem@microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, Paul Rosswurm <paulros@microsoft.com>
Subject: RE: [EXTERNAL] Re: [PATCH V2,net-next, 1/2] net: mana: Add support
 for coalesced RX packets on CQE
Thread-Topic: [EXTERNAL] Re: [PATCH V2,net-next, 1/2] net: mana: Add support
 for coalesced RX packets on CQE
Thread-Index: AQHcf02oLJOgwMZgokiNaAnIBRMMibVKqfoAgARiUFA=
Date: Mon, 12 Jan 2026 21:01:59 +0000
Message-ID:
 <SA3PR21MB3867BAD6022A1CAE2AC9E202CA81A@SA3PR21MB3867.namprd21.prod.outlook.com>
References: <1767732407-12389-1-git-send-email-haiyangz@linux.microsoft.com>
	<1767732407-12389-2-git-send-email-haiyangz@linux.microsoft.com>
 <20260109175610.0eb69acb@kernel.org>
In-Reply-To: <20260109175610.0eb69acb@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a41a4a96-4890-47ab-b3a1-7b7643558fb6;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-01-12T20:53:05Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR21MB3867:EE_|SA1PR21MB6034:EE_
x-ms-office365-filtering-correlation-id: b0d6df63-5932-4b3b-413d-08de521dd3c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?dZrPdZaKnw5TMkUsNO/JyiL2sVm5VsQWK/daPoBr4gpKyUO/mthBH6TG6fXA?=
 =?us-ascii?Q?lRw1EXE5+/SD1ycCAZ3JsKoQFRZ93hQRQGQkxiT0+3S5SrlW0FUqt3clNZTZ?=
 =?us-ascii?Q?FSqI8QHFfRnfXjNZ9Hf+zeqVxi91AOuKLPSBu9pFtKBJmY9NZffbg+o8NTY/?=
 =?us-ascii?Q?x4sEoq2UBYAhFnPmcq6EaDAJN3pnV6tn+IwqgQWynMKKl/usUsAQimMRqqMc?=
 =?us-ascii?Q?6CvcfKh7F+m8HysyPw3FEX4w0WbLkP9QB10MSlP+p7V6UpbAcEaJPKB4mrXE?=
 =?us-ascii?Q?ZWX9C1samhlGGs5jZzabb+7de6gmoJ2YryL6m2quW1zx54mcUiYlyK/mtZ68?=
 =?us-ascii?Q?0PH8LW3MJPMzv+/q0pyf7nw1pxSYh1+jriKoyG86o1Nv3ESmPBEfXa/Hz2hN?=
 =?us-ascii?Q?rZmY3uWStGqTltaGfBNR01V6WsfqyAluybSNREbYDMfxWvFYlEK6dEMBz5Zx?=
 =?us-ascii?Q?2EZOdtiDueZpuygajxb/25aErHzOW6S+5ape6wDhKMSlDVmh0Vzn9DeLAhWc?=
 =?us-ascii?Q?GvhA5vuMo5Qiuxt7BnEPgoXI8hEV0jJDtghoHMNj+RAmV4+UtSjaxEwACuHA?=
 =?us-ascii?Q?wuhiBZLLrUpKPbwVcCQMdE9hdOIZcf0vmUTpqiNuuTJg6TUItEGBBC1WN7EU?=
 =?us-ascii?Q?SWN+p5oNq+R435ZsDQ46jlLrVlhAhZ/TxbJ+e6XE+aYnIMZNjSQGUrhSmMtB?=
 =?us-ascii?Q?ffvVEuH4AM23pi99o3VC1kaikFkAeFTd+1Crh5W2H5M+FB8l6PMX1iDiDhQ2?=
 =?us-ascii?Q?CRXh+NBrP46qHlgbqy6G96E40nj0vFF81hvNt7nsAWif+CKbG7qIouQrapyy?=
 =?us-ascii?Q?4Wvew4PUnT0Ks+KxY7bJvTjCwKjgeFl8cMBIaAraaLQYNXSWL+zPU1ExqW3X?=
 =?us-ascii?Q?wT9y+SngZ0LOSpEeF6fHibw31V2+LeTdMLqLcx11mnWnbvFB6K784UJT75HU?=
 =?us-ascii?Q?DQc9Mh9Dv5HF8E9wd1yYWnpoqWxwNyL2OXXCqLeJrAhPg4i8E6Q/oXb+pBih?=
 =?us-ascii?Q?4c/ipZu9gQ22neylExl9gBchT8kEqKFGgMCVODUgG73IdHeWuxQMg1iVeSxP?=
 =?us-ascii?Q?Eg1BqQanBvJHDcjLyd3npMjjkiPVCWDtGyYckQMQyAoXo8nt/LzNYfI8QWSU?=
 =?us-ascii?Q?PSgjLMWNUYgOeS87FzfHHUrCmEhs0tKc73HCqzHzmB52Va5kbW35WfOpeF+6?=
 =?us-ascii?Q?6XDziwagBtX6mRUkf4A+X5w170HcGE7QezioRjck38UEGUBldL9miq2UWy/P?=
 =?us-ascii?Q?Qe9A1LQh6QZn/67ryaxehfkpKfaY5wqpbBw9gnN+/IAroNltz81KVLTfIvIS?=
 =?us-ascii?Q?QYoWZHr/EDed099zncCnQdIFMtJjwkAx4fxI6TsSSKfUQ9OwXQl7xB+j9W4I?=
 =?us-ascii?Q?HoCEXNh50m0NJ6wOocZ13ypRGkXeOvxTGgiMhbUtQeRYGBq0hGKpSftXkQEd?=
 =?us-ascii?Q?Gy9SFYqoPsQrsffGWfDpIzzYWW5Lg6ucHPDmWvy09AcQsh899kR/SJFkFggP?=
 =?us-ascii?Q?6cdjZm3b8FYCHLP9BytdEaZUoMvvsoloAKGI?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR21MB3867.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?J57/g2LtDASxhc1KMT+yI/ervyKiKkgQ0JdjJyz5z+XHRzDOsPxYbgF8oB1q?=
 =?us-ascii?Q?/XVbi7JItlJjP1Plv8oadxoB867kWCj0hh6rwMVtSRJILyT91L3KdQn0wXG1?=
 =?us-ascii?Q?UaRPw77LwKoVpQCO/cZseBz7y5iT7HAw0RGEZWGN2wf30P5Nh5Fy9lP02q7R?=
 =?us-ascii?Q?NQT5pTubL+c0t25epQMRFm03dj3LHUW4TGTwKBhHF2lF1YGJeQNybaMKO+r4?=
 =?us-ascii?Q?1IQN+3n7MsTyZYduwV9lGvs82XJWMMq26nsHkyaXn7zQvmvC0HZ9vBEQ8wzB?=
 =?us-ascii?Q?BT1UVB8/OUsu6cLgzo5LXHW3mgRZ4avQt6lYjXvVVfVe7NQGwVKBXZfmJsNk?=
 =?us-ascii?Q?uSPEsJpmzRrcfn2LRDE3XC0nuONRrgPwyHWDqlxntqGXA+JdleocwaChinq/?=
 =?us-ascii?Q?225BKjQvdwrNfgZ8o7kEldq6R6fVOT7A2CzlQizmey8O8Oce7eZ7ywPQ6MoD?=
 =?us-ascii?Q?bcuzvkBSIE6nbWXnRoPOq5F1qMsyLUI/v0rdYs67sChl4w2E3qHdBaLk+78j?=
 =?us-ascii?Q?2hytQCBEVL10AOW2Eqb/maRQuCq5OV72gAP5lo22WNNv3M0cFfXQrNLpkI+T?=
 =?us-ascii?Q?PHPomVFnGTO1pw6bapYzd56IinVgpGPKA2ic/rspRyzV/SyOG4P517DW8/IZ?=
 =?us-ascii?Q?4S/HsQFRjiS4zrwlAPv6RkV6PsagKwFgQ3krDguNaCyDzbBRE/CbtUIAxqqs?=
 =?us-ascii?Q?4TOFdosta5Xiur0hDTwo5G4eClkUamHpdWIiFLBqQs8jOcJBtv0N9OHPk+60?=
 =?us-ascii?Q?FJ1t/TOedk1DB5kG/Me+kL4ft7J/xFQE840CrsbQmRj8bVsIRdhUjpQrk3AO?=
 =?us-ascii?Q?Iftw4aIulcCJvBeUq3oXgmbMw1h+kCC3t/ZI8cRog6bxHUoJnjkRFbyNYrVV?=
 =?us-ascii?Q?gwRtsOScBmpL7Rm2OES9g4wVexTanFQJRvRMxkcbnIqjYFg7pewmBbj+obSv?=
 =?us-ascii?Q?X12YAPdEYeN6wSLrUvLt3UIqW8NS4m67kzdVEEV6qy3R1qPtoqiBwzbeBJ4N?=
 =?us-ascii?Q?voAtetVvy1TwUq/hutphx8cv37FHK1H1jR2zCW/knE/dGHDjAabUkrzR1+wt?=
 =?us-ascii?Q?ZhuflWKaEki34wio8mHsCnMyLe+wrIyPHbWAyRbqVWzda/WYIWaKAEcDa+7B?=
 =?us-ascii?Q?HaD3DKLUDm9grPRiPTAjk3cMlx1IBH5waWYwHaFTcJeBebzAI325sHg4hTEr?=
 =?us-ascii?Q?5xdF+ou1uPTfjvvoZ5xMW0zpIEANYdzPkebVKj85mHsvGfKsMi4YyHSef5k8?=
 =?us-ascii?Q?mpT6OI3nSSainuW8Td1/yT7+AlGDxxzQYyauRnvc2o+tvXwy1pcjZpXOqUxr?=
 =?us-ascii?Q?amgrtSifYSsz2f4DJK3dyZhyzGKRpx+qdeJupZ1kGPM5QK1AEuqHwxLoPvwu?=
 =?us-ascii?Q?gzJ8hMcGFKlNf75GSbdLH2sm4DuJaTJkIhg/ZBIxuPbG/32XbTstU11dedav?=
 =?us-ascii?Q?wXKp4gGpgD9iQg+adgmK+McIQL8WWd5TKLTlNvoZMX7aeGQxYXplosPWhtY3?=
 =?us-ascii?Q?g2ojWCz+319D0qZ7OQbObE6qQjC6h4a4lbh1gYOqytx0r99ndms4s88g9Rl6?=
 =?us-ascii?Q?mtuZYDAuCdfETr9se7A6aznGNpKkz9NW8H70IPQWiUKhkHQGmXBQscmo4NxX?=
 =?us-ascii?Q?rW2PIglDr6Ok1sdDsvqJZANT0QFVMGHjKaJBQ0c/Wu9R2bFaMgpeMC/pJTfy?=
 =?us-ascii?Q?lBx3LF5oafiw2fu81MSosGIf2iP3Vb3APzxYgDkdmxYk+egEW+r+ASOLMyjM?=
 =?us-ascii?Q?Jz7Fm7bOfQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR21MB3867.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0d6df63-5932-4b3b-413d-08de521dd3c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2026 21:01:59.3689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RX5IPMsiM1I11taIJbJiIsLszKjgUErJPj7LlZOkGRNDePiwq1ueTzfWmmN3s+eEalJZ0gQkMbju1OO4dZ+EnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6034



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Friday, January 9, 2026 8:56 PM
> To: Haiyang Zhang <haiyangz@linux.microsoft.com>
> Cc: linux-hyperv@vger.kernel.org; netdev@vger.kernel.org; KY Srinivasan
> <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>; Wei Liu
> <wei.liu@kernel.org>; Dexuan Cui <DECUI@microsoft.com>; Long Li
> <longli@microsoft.com>; Andrew Lunn <andrew+netdev@lunn.ch>; David S.
> Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Paolo
> Abeni <pabeni@redhat.com>; Konstantin Taranov <kotaranov@microsoft.com>;
> Simon Horman <horms@kernel.org>; Erni Sri Satya Vennela
> <ernis@linux.microsoft.com>; Shradha Gupta
> <shradhagupta@linux.microsoft.com>; Saurabh Sengar
> <ssengar@linux.microsoft.com>; Aditya Garg
> <gargaditya@linux.microsoft.com>; Dipayaan Roy
> <dipayanroy@linux.microsoft.com>; Shiraz Saleem
> <shirazsaleem@microsoft.com>; linux-kernel@vger.kernel.org; linux-
> rdma@vger.kernel.org; Paul Rosswurm <paulros@microsoft.com>
> Subject: [EXTERNAL] Re: [PATCH V2,net-next, 1/2] net: mana: Add support
> for coalesced RX packets on CQE
>=20
> On Tue,  6 Jan 2026 12:46:46 -0800 Haiyang Zhang wrote:
> > From: Haiyang Zhang <haiyangz@microsoft.com>
> >
> > Our NIC can have up to 4 RX packets on 1 CQE. To support this feature,
> > check and process the type CQE_RX_COALESCED_4. The default setting is
> > disabled, to avoid possible regression on latency.
> >
> > And add ethtool handler to switch this feature. To turn it on, run:
> >   ethtool -C <nic> rx-frames 4
> > To turn it off:
> >   ethtool -C <nic> rx-frames 1
>=20
> Exposing just rx frame count, and only two values is quite unusual.
> Please explain in more detail the coalescing logic of the device.
Our NIC device only supports coalescing on RX. And when it's disabled each
RX CQE indicates 1 RX packet; when enabled each RX CQE indicates up to 4 pa=
ckets.


>=20
> > @@ -2079,14 +2081,10 @@ static void mana_process_rx_cqe(struct mana_rxq
> *rxq, struct mana_cq *cq,
> >  		return;
> >  	}
> >
> > -	pktlen =3D oob->ppi[0].pkt_len;
> > -
> > -	if (pktlen =3D=3D 0) {
> > -		/* data packets should never have packetlength of zero */
> > -		netdev_err(ndev, "RX pkt len=3D0, rq=3D%u, cq=3D%u, rxobj=3D0x%llx\n=
",
> > -			   rxq->gdma_id, cq->gdma_id, rxq->rxobj);
> > +nextpkt:
> > +	pktlen =3D oob->ppi[i].pkt_len;
> > +	if (pktlen =3D=3D 0)
> >  		return;
> > -	}
> >
> >  	curr =3D rxq->buf_index;
> >  	rxbuf_oob =3D &rxq->rx_oobs[curr];
> > @@ -2097,12 +2095,15 @@ static void mana_process_rx_cqe(struct mana_rxq
> *rxq, struct mana_cq *cq,
> >  	/* Unsuccessful refill will have old_buf =3D=3D NULL.
> >  	 * In this case, mana_rx_skb() will drop the packet.
> >  	 */
> > -	mana_rx_skb(old_buf, old_fp, oob, rxq);
> > +	mana_rx_skb(old_buf, old_fp, oob, rxq, i);
> >
> >  drop:
> >  	mana_move_wq_tail(rxq->gdma_rq, rxbuf_oob->wqe_inf.wqe_size_in_bu);
> >
> >  	mana_post_pkt_rxq(rxq);
> > +
> > +	if (coalesced && (++i < MANA_RXCOMP_OOB_NUM_PPI))
> > +		goto nextpkt;
>=20
> Please code this up as a loop. Using gotos for control flow other than
> to jump to error handling epilogues is a poor coding practice (see the
> kernel coding style).
Will do.

>=20
> > +static int mana_set_coalesce(struct net_device *ndev,
> > +			     struct ethtool_coalesce *ec,
> > +			     struct kernel_ethtool_coalesce *kernel_coal,
> > +			     struct netlink_ext_ack *extack)
> > +{
> > +	struct mana_port_context *apc =3D netdev_priv(ndev);
> > +	u8 saved_cqe_coalescing_enable;
> > +	int err;
> > +
> > +	if (ec->rx_max_coalesced_frames !=3D 1 &&
> > +	    ec->rx_max_coalesced_frames !=3D MANA_RXCOMP_OOB_NUM_PPI) {
> > +		NL_SET_ERR_MSG_FMT(extack,
> > +				   "rx-frames must be 1 or %u, got %u",
> > +				   MANA_RXCOMP_OOB_NUM_PPI,
> > +				   ec->rx_max_coalesced_frames);
> > +		return -EINVAL;
> > +	}
> > +
> > +	saved_cqe_coalescing_enable =3D apc->cqe_coalescing_enable;
> > +	apc->cqe_coalescing_enable =3D
> > +		ec->rx_max_coalesced_frames =3D=3D MANA_RXCOMP_OOB_NUM_PPI;
> > +
> > +	if (!apc->port_is_up)
> > +		return 0;
> > +
> > +	err =3D mana_config_rss(apc, TRI_STATE_TRUE, false, false);
> > +
>=20
> unnecessary empty line
Will rm.

>=20
> > +	if (err) {
> > +		netdev_err(ndev, "Set rx-frames to %u failed:%d\n",
> > +			   ec->rx_max_coalesced_frames, err);
> > +		NL_SET_ERR_MSG_FMT(extack, "Set rx-frames to %u failed",
> > +				   ec->rx_max_coalesced_frames);
>=20
> These messages are both pointless. If HW communication has failed
> presumably there will already be an error in the logs. The extack
> gives the user no information they wouldn't already have.
Will rm.

Thanks,
- Haiyang

