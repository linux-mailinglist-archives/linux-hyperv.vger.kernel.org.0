Return-Path: <linux-hyperv+bounces-10707-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBptO2sH/WlLWwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10707-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 07 May 2026 23:43:07 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5163F4EF6DA
	for <lists+linux-hyperv@lfdr.de>; Thu, 07 May 2026 23:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A09D303429E
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 May 2026 21:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44608346A0C;
	Thu,  7 May 2026 21:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ButL1b/T"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023088.outbound.protection.outlook.com [40.107.201.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EFB3451B5;
	Thu,  7 May 2026 21:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778190185; cv=fail; b=Yzj1wbmdQDvj2V0bUJs8rCInvTKm5ZL3vPa8GFhhUTiwW2Q17UVqOH6UwEHcEON1YGuro6G9FyClgo9ZosjAXYJHJ2dT2UR1PErOjdL1dQdGpuPJHjXt31rzqHf1Xkc7mQpLsY+67nZdqqXUtcdo24ukhVZcMKI3BePffo0amy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778190185; c=relaxed/simple;
	bh=3b2ngwKikYRVuOpJ4BoHCcDWIZ1ZP87frIMIUMU2DGw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=APsSnRmZMRK0FsUYtpa8Ysff3cJ/MgjAzQLyeKOQdV43ZvKksGqeHGqo11ELaq0d/O4/hxlcmwgcUcsyPbOik4goqyja7J6yUPh0c0IyUQBJhfc3Sgo4foN+mrS6+NxPlyi9I/hbR8VF7RSIhWTXiuaArH0lo062AsmicdnaVJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=ButL1b/T; arc=fail smtp.client-ip=40.107.201.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dYsr9bmHiGIF8ulqCd9pIOOoy50094C4Kbm5V/VAjHOkWYdCXD+2v8D99OVy6tzLbxkDGjh3/ycuSTQNdG+AdBPCqniU4BGCj7mPr0sVEk6nUw25mmE8vr3Y5p0SfrdLNdKLw6IswselDm6Olva4+VRFLkl/minqLoFWZpfyUpP4zYMqydxGx4tbJgWpUEVvJYNgLhvcrhQvQc82AFYdJl6srbgy/ymseFTwpAZx4GQs7Y1eFFnXX97OHA6TnOHwj4EPyAzjzzj3SWZYX6hh/hHVI/iLpEiqDUuJStTsDFMu2JV0mIKlXQa0cBAuuWSsg2lyzh98mABSdRvz8N37FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPQo9ZMnYm8favVEHgXNP4x1QHZQ3/P/OSv+w0+nyjY=;
 b=hncq+yzrA4MyMj1ekpUIuuFTY1NrRtcBBddDwn2PhKlMbcL3ZnzGWMymtGaluvixwJ5/j1ras3oEVkKpTAC2+6T6Jg/t/Nbh1Eu0NFgM6HdVYJ5pz4n+xWvODVmiZPPSuC+OrECmA8QVxOg0sOrQguYIgc+6RLBJLOOEsH4GZ6sR+i/qCAjShpdZx1SHxeEcacbMgqAbAEDER4i3/94ByaHc6FtQB/B5OJbSDZTOwjHw5Kdq6V3urOh3MgmNb8MzjSl/3phTb8oV19oYusHe89zHcvMwoat0eCUCnVHDxVYtR+jo4P4QQnyeLGdHe7LPhu/yPK7+fqBsL9SZyaM2Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPQo9ZMnYm8favVEHgXNP4x1QHZQ3/P/OSv+w0+nyjY=;
 b=ButL1b/T0xbETTBIiipX+FBZDEnLR9y9HweJ56mOW6MTmAiNNiM3gIbxyuSjpkIlaiJ1hhET8qzwSXc7sHoggTvgxk3OFzDvAs6ZdTtzP/I1jwz9Olim5yR4V6OlFG3Yjp5KWQwekoOVRP2+an3XCRvBIpARXpk/LlVZS7UK9d8=
Received: from SA1PR21MB6921.namprd21.prod.outlook.com (2603:10b6:806:4a7::11)
 by SA3PR21MB5697.namprd21.prod.outlook.com (2603:10b6:806:498::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.3; Thu, 7 May
 2026 21:43:00 +0000
Received: from SA1PR21MB6921.namprd21.prod.outlook.com
 ([fe80::51cf:497c:e5df:f6d]) by SA1PR21MB6921.namprd21.prod.outlook.com
 ([fe80::51cf:497c:e5df:f6d%7]) with mapi id 15.20.9913.002; Thu, 7 May 2026
 21:43:00 +0000
From: Dexuan Cui <DECUI@microsoft.com>
To: Matthew Ruffell <matthew.ruffell@canonical.com>
CC: Michael Kelley <mhklinux@outlook.com>, KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, Long Li <longli@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"johansen@templeofstupid.com" <johansen@templeofstupid.com>,
	"hargar@linux.microsoft.com" <hargar@linux.microsoft.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH v2] Drivers: hv: vmbus: Improve the logic
 of reserving fb_mmio on Gen2 VMs
Thread-Topic: [EXTERNAL] Re: [PATCH v2] Drivers: hv: vmbus: Improve the logic
 of reserving fb_mmio on Gen2 VMs
Thread-Index: AQHc3WroSYifASCvgUCkf4bDaRgCsrYBvvhwgAAxr4CAASZzsA==
Date: Thu, 7 May 2026 21:43:00 +0000
Message-ID:
 <SA1PR21MB692159569CFAD9F59BCCEA2DBF3C2@SA1PR21MB6921.namprd21.prod.outlook.com>
References: <20260505004846.193441-1-decui@microsoft.com>
 <SN6PR02MB4157A5A68BDBC87995FCE85FD43F2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SA1PR21MB69217F13193ADBD59430FB52BF3C2@SA1PR21MB6921.namprd21.prod.outlook.com>
 <CAKAwkKtUo5XX_Qh4hSYcbxTWkZP=+i0hZQaPHX78G20MFdz2Lg@mail.gmail.com>
In-Reply-To:
 <CAKAwkKtUo5XX_Qh4hSYcbxTWkZP=+i0hZQaPHX78G20MFdz2Lg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2e999bfc-eb50-46f7-8b41-c4829cee2584;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-05-07T21:32:13Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6921:EE_|SA3PR21MB5697:EE_
x-ms-office365-filtering-correlation-id: d7386729-9f1c-4834-b714-08deac819c36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 Z9waJ9wb6GM1j7OJag937ovhtyvhauTM+5BmUzzsxKvDcQaOpi/3HZ5vUGsxWnLMdVtTgTx+4CqlUHQso2BIqgHYVK1yenSnEnGKPwHlAlratSqiZBbgwfw06DIzrrc6et8jdWxHJSP/U4Cv9beskU+es0d89sW2/0SQ2RXcmkmok4k4Sku9wPOVap4jCroVOYzI3KvoitF1YAc8oWuJM04em68klnmLaJt3WleTYXYF73G5IrHkDpnwbFYoT0thotstRFxjs87HcYQUCTc/5L4VKQwD2OeOu2D1PKt45wTt/NkWOr32iSy4JJKno26iQVAEttAYrZZbhVFCec4mElVxqCvlQ8+ZytijJh+bKEY3CkmDuRGhWKXsjqU7k1ueHd6XPo88sAF6HUT/8JtMa5p+moIkmU7kfW+wEMO2TtnPJLwBgVTlo7tpP5Ld6tWNcC+KDhZfcp0F4IkhSSTAYDZoq5k/CO4rP/pWW8jZ/uP1AFtEvOpZ/mSD+iCbD2dJtlZWKvCCMaim6k/nEiB06kcfCQtbXlB/PZy5pwP3a8ArPMm6PekTpu7nVawi8VWhBHtYCYIlPU5xWZT8KPx2LQhk7U+/9TrMYZqX96sgyc6msTDjoMtmkeovfgzNzHFYuhDTjevNAKq8VmJo4sXod1cnGxVgXOTT+FkHWTcSvQOc38TWHUX1aiLJqakaHdWfzrQDy3d6SYYeOMZ3kzVMfQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6921.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?D4sH5MRKJxq9996HxOqZmwOsfyxND0IvJ/8GRrYo6V4rItTNbTTJJX+JmfD7?=
 =?us-ascii?Q?CbSBvAhQGYIhqHB2FGBndYfxUNLZ28CuvMDiPZ8O6T9v6jm5MnhA/AtAZYgv?=
 =?us-ascii?Q?0devdDUQ2M3z80msaGBQ9d1KJ00fXatywPotXfhg8RjuKdo+EsC75Dywy+9x?=
 =?us-ascii?Q?EoADlDvSGPxe42JoKrmL8hCDOTSlmRskohWv7o9KD2/rEXtveRZmpAKWdlc7?=
 =?us-ascii?Q?TkM0G5Fs/yCXx7MMh5NWY42KDjXnxE7S+BzX1aILKJr4j+6G5IfvzuWZSq65?=
 =?us-ascii?Q?qoJUfejrhg7stya0JuhdilbKMenKbglo7107sls3TD5M+sksc5RuRvjzHKjG?=
 =?us-ascii?Q?9ewOBZoLTo/KZ4TL4A5cIrGwIZJjNYM92zmDsxOmV43/yfLcrztVc6ZQBqSD?=
 =?us-ascii?Q?HnUuiB9EcpMGhauvifdRcdNVD7UxOJoONjEodhobVQrHXEh65MUMxn3AGQHI?=
 =?us-ascii?Q?60sXnubSIDtwCSqdRe9oCggjMay7WhN3xGt/XH9esPWWEMgibmOBO8dw3Jz/?=
 =?us-ascii?Q?FrXXJmuhhIk3MnpvksU2bvvxJE3BW28OyuZLz1gCZ1v6DhiT37AqO2jsmCqa?=
 =?us-ascii?Q?iFQE/xwVPGBRjodX6W0IZN/FKOVXmsG/tBVSb55I5hu0535oCbCTUDwGCE5K?=
 =?us-ascii?Q?YkwQCS+yxvSp56I5P6xPiBc6aLJe9DlVFcwCuuZ8nRfO9S09NbkW7H+Pwjml?=
 =?us-ascii?Q?Ie47B0evmkPfgrzuz0JUJ5Bl3l1iNUnCkEnWsjU3fKacBCqMviIcZR3qznO5?=
 =?us-ascii?Q?JrsidcdFXCOhjBlA8UlnEgjV9dLmiUNx9DCY5A5RoD64XRf3wn7YGuqgNZ7I?=
 =?us-ascii?Q?imWqn08mrU0tZAQT3Arhjr2UyK3aJ/77I7+bd1VPbozC8kLn3aIXBPZOG/Eq?=
 =?us-ascii?Q?CY3Aul91RBl6PtdapfG9Z+ea7cOEtwZZmclPbyvTstf2MGmFCI7XLPT2Nnsx?=
 =?us-ascii?Q?fjlY0ToAT2RTc1F7ipGepeREWSZU2UQPs+IXomQkm2V93MEU5lNtxGM3+Yje?=
 =?us-ascii?Q?FOatJzZtB1NcLDSqDfce+0kVVFpHSHgYpKPK9OyUKHFNXkoAeNlE18K57udu?=
 =?us-ascii?Q?r/yOfBnldFbiDn3Ol0MpzEor/Cx3VjoeqkIjS4ARlWdHjRnMBSYHfLbcn5Gb?=
 =?us-ascii?Q?Vsz5bWa1bxUsMSZllapvXZLd7MUppSa/XDAKH5E/+pKLnsl9z51YiZDfZZV2?=
 =?us-ascii?Q?nYGweQ5NiQ56ax5cASN5gwcUEavgrZ5fOt6RQZKtLgdlqUu75Ah19uQnHPXN?=
 =?us-ascii?Q?+txeyaWnQPLuef1z9Lwd/QYkR9W9SwWQdbTKx/yqYKELDN5glCSzPV1GTIuG?=
 =?us-ascii?Q?sop9YpLxPMej7fKszDRUPhHFAJ4D43puo32VCRmc3yUWLTPtWf9arP+U2JsH?=
 =?us-ascii?Q?kwMMIKmcgtm+CZDpOizy+aOu8qvjxNbg3nV9T5ZC/kWgziyAt6CS7lQY+dW6?=
 =?us-ascii?Q?vrolN/lZ9dlkEoTiWSmotbN8z/o9zkA0G9CeVmX08LSMqqfBcxZMi/8jmQ6Y?=
 =?us-ascii?Q?G7nTcRfqWeeSoGJPwCOP+Biuebd2Vnv+q5dlrpdFjNXGDHJwjMM2cEGVaALG?=
 =?us-ascii?Q?7W1oFRuMyJPb+9JHGgpkrXo/4Bb9fE6anCkhTKvWoKHUQCy1E0GwVmdVy6Pq?=
 =?us-ascii?Q?LPEQRbIGT9sSpEwBBXZaG43IuS/RnMmHB+WeS/RhW6V1PlF+2mo0W3s0ggPE?=
 =?us-ascii?Q?o8nKjLNIe2Kky8wdBZGib6ro/yppJGmWWR1dIiQ77DosKKXt?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6921.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7386729-9f1c-4834-b714-08deac819c36
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2026 21:43:00.4447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cchWT/AzJ+p2rVRZa8fkqBu3xTsvbd0kzEuV+FUMxP0Q9sqiuZeLij8sMh+o0iazcrbyXxgL+xYGp1N9tdlQzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR21MB5697
X-Rspamd-Queue-Id: 5163F4EF6DA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10707-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[outlook.com,microsoft.com,kernel.org,vger.kernel.org,templeofstupid.com,linux.microsoft.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[DECUI@microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,canonical.com:email]
X-Rspamd-Action: no action

> From: Matthew Ruffell <matthew.ruffell@canonical.com>
> Sent: Wednesday, May 6, 2026 8:58 PM
> To: Dexuan Cui <DECUI@microsoft.com>
>  ...
> Hi Dexuan,
>=20
> Thanks for making the amendments, and thank you Michael for all your
> reviews.

Thank you Matthew and Krister for all your help with testing!
Thank you Michael for all your valuable review comments, great analysis,  a=
nd testing!

> Since you posted the diff to the V3, I went and tested the V3 patch.

There is no real code change between v2 and v3 :-)

>  ...
> Tested-by: Matthew Ruffell <matthew.ruffell@canonical.com>
>=20
> Thanks,
> Matthew

I just posted v3 here:
https://lore.kernel.org/linux-hyperv/20260507212838.448891-1-decui@microsof=
t.com/T/#u

