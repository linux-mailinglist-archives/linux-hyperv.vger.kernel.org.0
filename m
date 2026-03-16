Return-Path: <linux-hyperv+bounces-9451-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SP1ZECVuuGn5dgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9451-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 21:55:01 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD8B2A06AC
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 21:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9AD0307AA32
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 20:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A13835AC05;
	Mon, 16 Mar 2026 20:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="JlKM9ktD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020103.outbound.protection.outlook.com [52.101.193.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7003635AC16;
	Mon, 16 Mar 2026 20:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773694426; cv=fail; b=Krx/nN5WDI4HV3oaqgXf0GOziNfk25+EKWUjNtJQb//Om35kxVcFOUDzWrvyKE6Qu8x0X9b3RMIbCj5M9dsUtsA3HPMLnJ9nxBuRO5wwkjJyrFR1spC/KqvGMeqgqmO6aswTIgXg/32TjW2Wy5obs0tAMjCpdjzubq7g1pjV2hA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773694426; c=relaxed/simple;
	bh=nQYqtO5v054FnIVnHoAXtKMD7Aft13Z/Mf9uOBXS/S0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YvMwQZmCkU514a1Yis0dhFabynQiYB9XTerl9wcoBnWdh03qPetIrcE50TVXozj2lyOSBrUj0CAkH2qG/4sa26D5/ATAwZOz0jLwsJRKfmKjP4ocBIbJbyYLpnQ8qLt3mcNvRy/mH2wplnFIf2gVRAueIQRoz9dOdL8Vmo9ttnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=JlKM9ktD; arc=fail smtp.client-ip=52.101.193.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CcztQqprnYyeqVvu1njEQGLi3/otyRdd/SJJzOrcEy2clKjquBZr4Zwj/PhZaFApsGWt2ZgcFmbEs8vld0QoKlcaNFrHopDA3kGbkslPwiFnxvMMYUbkBP3TwWqxHzNcwVKH7fl5a2GlwEtFG78kQ9UcKbhnrCI+CIlvLtF0Kbz885o9P3g1zZVTpn4K5gwez9QcDOCnZdNTGlfdHeSMLM5zZaW/iGPBlqiDnViAoVFIEgMCnFh22/swvoAHJGVsscdaM8H5BIFmYLy1bWpvN572644p5y6K/WTy28cqC5t4Q9jAqThIhFXylOLkXyeSBBv+AAz/KNMbvTk3/JTtvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UhOb+83b42Q0HdLBvpntvrXH68KPV4Xhyonn9F03Sec=;
 b=Houis6m0xWx10aqztvtsnM5oK14bPFsWRtQnpGOTs9v2WnxNciU37wEdKhVnJjm1A0oYDgxQ6Dx48kfsMtGv/Yd4loMhWGydsAMSfdRwixiR/mxPUkoUpuBBoLK64UAAMIkOLojq/i0X5fDtWXflweoojpAipi7h9pCDp6iZnApQcyusR+S+J6AqjiSi4vFM0baY2AXfWZaCd6oIdndp7hC2AsGUnMHr3UrcoTCndrV5HpV2Bd0vooU6zzfyue1mvkIlj5fXvexoSvgRyKM+1ZKelyOOIWO3ZSiGCH2+0YmLArPWtnpctFGq1W4ABDe0ebsNuZcjnwkitSomJPZg/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhOb+83b42Q0HdLBvpntvrXH68KPV4Xhyonn9F03Sec=;
 b=JlKM9ktD2+BiTKJ0552T+00mhMtyiorIrTVbfO/lb9fjDTqXgNgDIeQVO/DwYTu/NTsI3KWcgoXIU3e31zZehRDXlP/K7GHTSrETozS8SH8NTbfMTlbEigHMg3jHYpJcQDEgeQAGVt30gK4yxd/0EuR8UjiRjV8t/I8ywWek7ow=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA1PR21MB2051.namprd21.prod.outlook.com (2603:10b6:806:1b6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.4; Mon, 16 Mar
 2026 20:53:41 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219%3]) with mapi id 15.20.9723.008; Mon, 16 Mar 2026
 20:53:36 +0000
From: Long Li <longli@microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>, KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan
 Cui <DECUI@microsoft.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kwilczynski@kernel.org>, Manivannan
 Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
CC: Rob Herring <robh@kernel.org>, Michael Kelley <mikelley@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PCI: hv: Set default NUMA node to 0 for devices without
 affinity info
Thread-Topic: [PATCH] PCI: hv: Set default NUMA node to 0 for devices without
 affinity info
Thread-Index: AQHcsnBlLEk5nWOmQkaR1EuarLdWWrWxavaAgAAEvnCAAB4UgIAAGsGg
Date: Mon, 16 Mar 2026 20:53:36 +0000
Message-ID:
 <SA1PR21MB66836F5290A715D1262F4A55CE40A@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260312223244.1006305-1-longli@microsoft.com>
 <SN6PR02MB415748A42DCBDD8AB635838DD440A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SA1PR21MB66837DDAF5F203E832DA5339CE40A@SA1PR21MB6683.namprd21.prod.outlook.com>
 <SN6PR02MB4157BBDC4D3A535D55B7E31BD440A@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To:
 <SN6PR02MB4157BBDC4D3A535D55B7E31BD440A@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8efea06c-ec40-4148-9aba-9c39a333c93e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-03-16T20:51:48Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA1PR21MB2051:EE_
x-ms-office365-filtering-correlation-id: c5e824a9-eb4b-4f7d-c1f8-08de839e17f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 M0yCY+VBiVFNjZrvR232aurAExDXy1bFa7Fz8m4mZXqsPnc9gcekt4Gqq7Y4BRBIgrBH+iERl+NvT9ohtU1CziWoOZ0CUmYeBH8bdl2i3xEiHaCqgSass672pl1SttM4CmgY5OQ8x/kaS9ZKJExUdxXc3DQQSFvsvVFe1ZRZPnk+kLNuAFGe8RK4GwvQP2V8A83PjOPqwDyw9ZMmojBM7f92OBtnheyaDTipASsMI+P6KHv5PHnklxm7kHQ5DtBIFYtNKidEo28MOSGHyLjsFAAi3F0zHyU0BDrVvcPCtEWELsTw2nSJ1qqg2cMcEc3CBUGscEDqDWun6UtkyUQdiBt2lRpJaOgh/St3RNlw0cLYZ6hSNYXxfv1yl1ppSRMF5/u52avOdLIme4lncxRJkx2OfAPpwwMF4EHT+V2bxQ3nc/uK9p2VZasAxE6cID6qVr3bVSu4BmlbLAm09O9ZNoGYfZSAUm9j204Q7RPejZuWjes/31xEuHOhFSRPHgapV8iblkNibC3kSZG6x3LZSGX9THnGnXGzZqHZWb/hQHP9QLs7eI3vSwRLw/mlIsBFA/DmD616L7B1VsW0pH88S/Cb8rFut6/XO8bWYJnsJpssn/Jbfx0DydBgEd9ylgQuccM0uqGds6txWbSkR/MgNJz2gQ5ykd/JEdcSybxJzuLXHLrEqysVHSI3D7FWfU2W/55OrHJAKJUyMpQIW8F6go1SRhLVvhcWPlgt2p8wvXPoI/7u8H/9RMS/r1BjluYk3XxgDoDlOo//LK+A/dBUXUeubBWKpAVjBo8ctbDwaIY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?33OxzjThEivtW/YXVgUeH8CBO4Q+SF0QCqfoRsJcMgmJCUoZjknSdsuvNU?=
 =?iso-8859-2?Q?49yCRk/w7jugvPyGy0dO4Sj1pcdb7OSlxhrQcA3s1gnu/9lwNv4FLyg/M+?=
 =?iso-8859-2?Q?0wr2BzJOVAHctdpptMoButpZoAMhkdBsxL/Ba/ma5GIpBx4BdEy8trua5Q?=
 =?iso-8859-2?Q?g3/bgOVHBRV94YGD1OqIuohv1XVR/OA27AAETWsI8eYuw/tio3XYf8P70/?=
 =?iso-8859-2?Q?k9HdeDbRyIy9onVkLA0/Cf9yOOo/7vBUU5IMQ+/GDDuPeCKfJj7O6r6q6d?=
 =?iso-8859-2?Q?weKuvmC4Cg1nT08vWBWt/7+gOzlFPXEy2oik9Y85l9d4Fmf+fzuFOmYyvG?=
 =?iso-8859-2?Q?9OCBk1JjhR9R/FDE8aw5SDGH7WfAW3Rb3e2FvpRGK2FiK1F7Mm5/inRQ6S?=
 =?iso-8859-2?Q?N/LKgoF+CXXuBnUP+hkTu6D4V0A0/3FRH9PT0L9uiCtlcUGTIZq9LVjUF0?=
 =?iso-8859-2?Q?8GwaCIIQUiYQiPwI8Ecw7vOkiZ4TdzNO8oCpZI/rKeyG7dAYZ51uTpHHKx?=
 =?iso-8859-2?Q?xxBZpEf2/Z6wLVEy1pwQZqmzV2G5IcYxzcpT+aavcjSRHgjk3DOd9t2+8Z?=
 =?iso-8859-2?Q?WUsXxywKS4wZVoGrOWR+oR8IamWzrLP8G+dzd19RPPuvrcCYFBu1Akp5jt?=
 =?iso-8859-2?Q?AKV2biHpCCqHwo9MnOT19cRa5lsRIfC7+Fs4rprRCp4mSUWBv3Rr8nGpua?=
 =?iso-8859-2?Q?glgl45Ik6upQetShpU9TJgyU7/BS3EqiV3w7k9gPhw9PvAhCZIj9aoCN88?=
 =?iso-8859-2?Q?CSDLhH1zBIcFDab5nqWAVjuMhpJ8NT1kRqtVHjR8/5+oY5vVXnzTZcVGj1?=
 =?iso-8859-2?Q?A+bMgiV5UzCzehRhX2GrlGRz7errfD30PJ/hPVp1vcR8DZqFvRl8FSWl/j?=
 =?iso-8859-2?Q?gh1jf/vsop8dzc61DDjUtRGgSs/Ssh5mHOQOmG3RfOEePSsGrP8By3w0VV?=
 =?iso-8859-2?Q?y3MGHMcfhOdipy4IjbnSZbCLEXEDq3BuYjftMySqjbWpl9HFt/1vjTifab?=
 =?iso-8859-2?Q?grJ1vPGhfQ1Mk7gD6P4mYUIZPcdfseWjffq0NbTTvnQe2Zw/m7L7TrzfXL?=
 =?iso-8859-2?Q?JYo3OkkgchlzDNWuUIOdPocTzbUnEmb8vlZVX9XNXiSSAhRvstLFwWtkjE?=
 =?iso-8859-2?Q?EsyfpvObw32tjo6qaiWX/M+mCWEwExpVIDQ50xne9uYpi242ee4Eaijg7m?=
 =?iso-8859-2?Q?xOfS/UfKs+PZMlmofpQSjPZNlJeOvB8mwmQpn5ZV0Hk+fYIeG/M5ypsKp/?=
 =?iso-8859-2?Q?D2q51Cnzbu6F7DnkclIT5HXHhOFXQ64ppMP0S02uDKx1xpoQ07zdV191JT?=
 =?iso-8859-2?Q?lscjb+ADP6XFZPiA9bU6vBEPIcM1RndO8t541HJQ5Rvd2Cf0FkEPUS9t7q?=
 =?iso-8859-2?Q?jwJSyBH8wK0h8gB0YCbfc/TKrDK/ggyg9SNE5hArTRQgCI0c4RS0UAGfRa?=
 =?iso-8859-2?Q?iRFVHdVjQyCwz00KhJMMw5r+OLNy3L2pFemqFu4/V5NjprdArXuqNTgObw?=
 =?iso-8859-2?Q?ME4xDoeRIRd6qnOHEgrdJlcDbXrIOL/Y/5dBSsEVRwEopyDKkVqvrDLUK+?=
 =?iso-8859-2?Q?C7UYrmWLADEfajpaJP7kZZv7O0A+QUBpqQWy9+fKGqPftbB12d/vjHgjMn?=
 =?iso-8859-2?Q?Zs1o7IMYbYbXCTth+Mik5RStj1wt02FbRl0SU2LCANk1cHffHQLvqI3Sor?=
 =?iso-8859-2?Q?heGk9WBAe2MnOyYsuaK0j4cPbnW3Ps5eu1wwGXFFsPmsBQyPlNuiiYZ/j9?=
 =?iso-8859-2?Q?9cHDDog1lbkxvenqGEpIiyaRWmdwIO04YfFPuT5BhPbwfj?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e824a9-eb4b-4f7d-c1f8-08de839e17f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 20:53:36.2632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 763tBgAHme6FFSy6bs3XBUt7RyF6WseH1xYQuKUHu82FQKLQPg4Lzv2a5k8MmlxaE+L7h5Lqcq6sU6ODpo0apg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB2051
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9451-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com,microsoft.com,kernel.org,google.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,SA1PR21MB6683.namprd21.prod.outlook.com:mid,outlook.com:email]
X-Rspamd-Queue-Id: 9AD8B2A06AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Michael Kelley <mhklinux@outlook.com>
> Sent: Monday, March 16, 2026 12:16 PM
> To: Long Li <longli@microsoft.com>; Michael Kelley <mhklinux@outlook.com>=
;
> KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Wei Liu <wei.liu@kernel.org>; Dexuan Cui
> <DECUI@microsoft.com>; Lorenzo Pieralisi <lpieralisi@kernel.org>; Krzyszt=
of
> Wilczy=F1ski <kwilczynski@kernel.org>; Manivannan Sadhasivam
> <mani@kernel.org>; Bjorn Helgaas <bhelgaas@google.com>
> Cc: Rob Herring <robh@kernel.org>; Michael Kelley <mikelley@microsoft.com=
>;
> linux-hyperv@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [EXTERNAL] RE: [PATCH] PCI: hv: Set default NUMA node to 0 for
> devices without affinity info
>=20
> From: Long Li <longli@microsoft.com> Sent: Monday, March 16, 2026 10:38
> AM
> >
> > > Subject: [EXTERNAL] RE: [PATCH] PCI: hv: Set default NUMA node to 0
> > > for devices without affinity info
> > >
> > > From: Long Li <longli@microsoft.com> Sent: Thursday, March 12, 2026
> > > 3:33 PM
> > > >
> > > > When a Hyper-V PCI device does not have
> > > > HV_PCI_DEVICE_FLAG_NUMA_AFFINITY set or has an out-of-range
> > > > virtual_numa_node, hv_pci_assign_numa_node() leaves the device
> > > > NUMA node unset. On x86_64, the default NUMA node happens to be 0,
> > > > but on
> > > > ARM64 it is NUMA_NO_NODE (-1), leading to inconsistent behavior
> > > > across architectures.
> > > >
> > > > In Azure, when no NUMA information is available from the host,
> > > > devices perform best when assigned to node 0. Set the device NUMA
> > > > node to 0 unconditionally before the conditional NUMA affinity
> > > > check, so that devices always get a valid default and behavior is
> > > > consistent on both
> > > > x86_64 and ARM64.
> > >
> > > I'm wondering if this is the right overall approach to the inconsiste=
ncy.
> > > Arguably, the arm64 value of NUMA_NO_NODE is more correct when the
> > > Hyper- V host has not provided any NUMA information to the guest.
> > > Maybe the x86/x64 side should be changed to default to NUMA_NO_NODE
> > > when there's no NUMA information provided.
> >
> > Tests have shown when Azure doesn't provide NUMA information for a PCI
> > device, workloads runs best when the node defaults to 0. NUMA_NO_NODE
> > results in performance degradation on ARM64. This affects most
> > high-performance devices like MANA when tested to line limit.
> >
> > >
> > > The observed x86/x64 default of NUMA node 0 does not come from
> > > x86/x64 architecture specific PCI code. It's a Hyper-V specific
> > > behavior due to how
> > > hv_pci_probe() allocates the struct hv_pcibus_device, with its
> > > embedded struct pci_sysdata. That struct pci_sysdata has a "node"
> > > field that the x86/x64
> > > __pcibus_to_node() function accesses when called from pci_device_add(=
).
> > > If hv_pci_probe() were to initialize that "node" field to
> > > NUMA_NO_NODE at the same time that it sets the "domain" field,
> > > x86/x64 guests on Hyper-V would see the PCI device NUMA node default
> > > to NUMA_NO_NODE like on arm64. The current behavior of letting the
> > > sysdata "node" field stay zero as allocated might just be an historic=
al
> oversight that no one noticed.
> >
> > I agree this was an oversight in the original X64 code, in that it
> > sets to numa node 0 by chance. But it turns out to be the ideal node
> > configuration for Azure when affinity information is not available
> > through the vPCI. (i.e. non isolated VM sizes). This results in
> > X64 perform better than ARM64 on multiple NUMA non-isolated VM sizes.
> >
> > >
> > > Are there any observed problems on arm64 with the default being
> > > NUMA_NO_NODE? If there are such problems, they should be fixed
> > > separately since that case needs to work for a kernel built with
> CONFIG_NUMA=3Dn.
> > > pcibus_to_node() will return NUMA_NO_NODE, making the default on
> > > x86/x64 be NUMA_NO_NODE as well.
> > >
> > > I've tested setting sysdata->node to NUMA_NO_NODE in hv_pci_probe(),
> > > and didn't see any obviously problems in an x86/x64 Azure VM with a
> > > MANA VF and multiple NVMe pass-thru devices. The NUMA node reported
> > > in /sys for these PCI devices is indeed NUMA_NO_NODE.
> > > But maybe there's some other issue that I'm not aware of.
> >
> > Extensive tests have shown defaulting NUMA node to 0 preserved the
> > existing behavior on X64, while improving performance on ARM64,
> > especially for MANA. This has been confirmed by the Hyper-V team, and
> Windows VM uses the same values for defaults.
>=20
> Ah, OK.  That makes sense.  I'd suggest doing a new version of the patch =
with
> the commit message and the code comment describing performance as the
> main reason for the patch.  You somewhat said that in your current commit
> message, but it got muddled with the compatibility discussion, and the co=
de
> comment just mentions compatibility. Compatibility between x86/x64 and
> arm64 isn't really the issue. The idea is that hv_pci_assign_numa_node() =
should
> always set the NUMA node to something, rather than depending on the defau=
lt,
> which might be NUMA_NO_NODE. If the Hyper-V host provides a NUMA node,
> use that. But if not, use node 0 because that is usually where the underl=
ying
> hardware actually has the physical device attached. Node 0 might not be r=
ight
> in certain situations, but if Hyper-V doesn't provide more information to=
 the
> guest, guessing node 0 is better than letting the Linux kernel do somethi=
ng like
> load balancing across NUMA nodes, which could happen with
> NUMA_NO_NODE.  (At least, that's what I think happens!)
>=20
> Michael

I'm adding the performance part to the commit message in v2. The compatibil=
ity part is still valid in that we want the consistent kernel behavior on X=
64 and on ARM.

Long

>=20
> >
> > Thanks,
> >
> > Long
> >
> > >
> > > Michael
> > >
> > > >
> > > > Fixes: 999dd956d838 ("PCI: hv: Add support for protocol 1.3 and
> > > > support PCI_BUS_RELATIONS2")
> > > > Signed-off-by: Long Li <longli@microsoft.com>
> > > > ---
> > > >  drivers/pci/controller/pci-hyperv.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/drivers/pci/controller/pci-hyperv.c
> > > > b/drivers/pci/controller/pci-hyperv.c
> > > > index 2c7a406b4ba8..5c03b6e4cdab 100644
> > > > --- a/drivers/pci/controller/pci-hyperv.c
> > > > +++ b/drivers/pci/controller/pci-hyperv.c
> > > > @@ -2485,6 +2485,9 @@ static void hv_pci_assign_numa_node(struct
> hv_pcibus_device *hbus)
> > > >  		if (!hv_dev)
> > > >  			continue;
> > > >
> > > > +		/* Default to node 0 for consistent behavior across
> architectures */
> > > > +		set_dev_node(&dev->dev, 0);
> > > > +
> > > >  		if (hv_dev->desc.flags &
> HV_PCI_DEVICE_FLAG_NUMA_AFFINITY &&
> > > >  		    hv_dev->desc.virtual_numa_node < num_possible_nodes())
> > > >  			/*
> > > > --
> > > > 2.43.0
> > > >
> >


