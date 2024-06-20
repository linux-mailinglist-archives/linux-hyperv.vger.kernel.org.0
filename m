Return-Path: <linux-hyperv+bounces-2465-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB2E91162C
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Jun 2024 01:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 579FAB2396A
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Jun 2024 23:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEF7139CEC;
	Thu, 20 Jun 2024 23:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="fOGmpU/d"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2135.outbound.protection.outlook.com [40.107.220.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF91282D83;
	Thu, 20 Jun 2024 23:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718924449; cv=fail; b=TH/1TZ2bv/vtg0nEloRbJe8Uhtt5LgdwFaQKhCYGx7dh50ShvMaPQuu/pLZYuQlXd54Z4VtB83aaBWd3pazm9TC73qJ4thIY8TJEicHO66cFhi+V70RGn0y30Yt9WgldjEQab5AePHWzojGLl/vfC+yoOWLfyF5eE9gdYf4oWXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718924449; c=relaxed/simple;
	bh=cdYimt3L3kMP4lE6rf2nbagJ3FLfjdxJRqInaqYo4Mk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m2Vd+pjz4Wnnz+c2+eaY8qC+Q7GEXXNIQ7Cw5FqBFQMAS/C8FD4p4AbPMNXTVSS89f6lsylRpI3mdyB1NhjfNf0/3ABcGPvE54I9B8kg2XN3NIaJgKZyobdKanHYp62zIvq6sw+s9y7odwFDLdKuIWDotTVVkdNHZ9D4GyOScXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=fOGmpU/d; arc=fail smtp.client-ip=40.107.220.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jIu95bNRGcxf3s8iWUEYYDCyuD+aCHe1A5cAF34FWDRgQh+gJCbp34BiC8+4HVW6XR/Liv/0fs1C2aUuDBS352A0fLraRp7KjcxKkm4kKZkclJQouIBSZjgwp5Ali2EZprh9Dq7INWIWlmMje93U0tqwISR1Y39UJQifqvgofrXbCQ1vItYtCcSKqsbmUW8TsYKCjGGCklHHDUtodEDRBqzj/gSZQm8axKNOJ4BZDTmgw1FvxjYHRPwV5Bn6B3zOc3OeUgHE0XfSMrFgLioqFr3pLxRfhbCwd/fIcudVVk1tvbcN6TKUWUOQ5K9Rc912Zxu5mb5acqehzsHtrE1l5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FqoNwMrASskLzd7bQ9fiC/krZ5zyV/BoIqUOGnjEOw4=;
 b=cMcFIna+d5kMIi6EYJS5HvWl3ma0Rv6G0b27AgnyfQ1PiSXWanmFbm4y2WxY2Ykn+DBG6KkOTrlIggvOC3e+x8OPYY2nz+r/UFvyaA8T1AofG1/p2wcNP6b3gMEw7t1Z/S8//vCtcJp8I/0Dh9iSPBYR5GPe27y+d77hElg14Qs33AXmLS8kreCunx9285sA96bN6+Ofx336vHLWxsx/ree8kyaQ+pSkfxY1xOI/Wupb8pGjek10r9pucAZrt6GfFGn0iuRkRXLpw3+EDSYSw8OrkCFa8tvXvR3VgZx1jqk3zusTTHnIytJFVJFe2gLRmhpSeZKFgGNDmuDrX+g+Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqoNwMrASskLzd7bQ9fiC/krZ5zyV/BoIqUOGnjEOw4=;
 b=fOGmpU/d7AWED5/PtmeL+7J9fW2SxW2t/DlhxSKltMehVddjWAvwg7QXR01D9c4Sn7bZ+chdR4cQivXZVC09z9qDHUj2FUfEDiODM95r/7sCTma9JTdYZn+nKlVWoZ298hlCOMi1eYsC3TcNqCYLz//++4wEV3w6ZVhxFRhE8AI=
Received: from SA1PR21MB1317.namprd21.prod.outlook.com (2603:10b6:806:1f0::9)
 by CH3PR21MB4495.namprd21.prod.outlook.com (2603:10b6:610:219::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.9; Thu, 20 Jun
 2024 23:00:40 +0000
Received: from SA1PR21MB1317.namprd21.prod.outlook.com
 ([fe80::67ed:774d:42d4:f6ef]) by SA1PR21MB1317.namprd21.prod.outlook.com
 ([fe80::67ed:774d:42d4:f6ef%5]) with mapi id 15.20.7698.007; Thu, 20 Jun 2024
 23:00:40 +0000
From: Dexuan Cui <decui@microsoft.com>
To: mhklinux <mhklinux@outlook.com>, KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "H. Peter
 Anvin" <hpa@zytor.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "open
 list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>, "open
 list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] clocksource: hyper-v: Use lapic timer in a TDX VM without
 paravisor
Thread-Topic: [PATCH] clocksource: hyper-v: Use lapic timer in a TDX VM
 without paravisor
Thread-Index: AQHaw1dzGN1D1i8Xp0qPmqmqEke8wbHRQqVg
Date: Thu, 20 Jun 2024 23:00:40 +0000
Message-ID:
 <SA1PR21MB1317ADFF74CF19B691D3CEFFBFC82@SA1PR21MB1317.namprd21.prod.outlook.com>
References: <20240619002504.3652-1-decui@microsoft.com>
 <SN6PR02MB4157C155D258F9DE76650E3FD4C82@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To:
 <SN6PR02MB4157C155D258F9DE76650E3FD4C82@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4dca9f54-38af-4e60-80a3-af7913c87f7e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-06-20T22:53:28Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1317:EE_|CH3PR21MB4495:EE_
x-ms-office365-filtering-correlation-id: 5f4c5920-5d17-4dc2-1a84-08dc917cce41
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230037|1800799021|366013|7416011|376011|38070700015|921017;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?8Yi5k6m93EdNW9rlniTToZdZS7nHn95LAgVGZEnef7SINDEgC0TTZvaK6RDj?=
 =?us-ascii?Q?RBjfMCfmnjrkyDP+nw3zOYy+c0lGsMOR+vpWhnHyhqiyGwffHrDx7/fHeBgf?=
 =?us-ascii?Q?BuRRXEkxMWFiOg/QF647DUcfsl5ofJGo1Ik8BG2+wK26Mi/4uENUbTZWkNc3?=
 =?us-ascii?Q?RssxP7qxxhqFGP7NY+LrglJs8TRdrGxN6enbng2YnQ0WYPcn7adPWfeZQy8p?=
 =?us-ascii?Q?k/KjfeZu1N8nRomYS/rW3yfQCwolhfhS3WXVnSzZvUn+ww03ox4fzr/Ee0kE?=
 =?us-ascii?Q?gT1E6KdnHSLGErHWpeYxLu/hmYVS9plAdnClrXdtrAjt1xXGCGjuALdtBqKz?=
 =?us-ascii?Q?ELYBMDMZiLGtx8gpmo96VO3FJYBcfLUGjhYKYn/RSl5/dBRUR3RLzaxDjTfg?=
 =?us-ascii?Q?OdANIImRuz2Avbvvi7JZd+XUj0g4cZEYW5R1LCLspfAQ1xwi7sD4fdBU3Eb0?=
 =?us-ascii?Q?ZDbO/Kj1/sROLVu+3yPWaIJSsse8BwPmMByk76uXqGP6x8iNFEqh+99H0HKn?=
 =?us-ascii?Q?j6Tk993VyOxD14Qy+ylyYHmQ/KWFUB1N/d9wi1n9qLGosVxG3qSqxQd6DGmh?=
 =?us-ascii?Q?exJ//iCE5crS4zrCe/Pf/1loFTwYlWgrSfb/BY0Ia72opcxMpr8SkWF/02m5?=
 =?us-ascii?Q?MX39GQMM9PKw0YtatPPu4n0FqTSj5Af6Gu43z8CM/eb/lhN7qq+oeCqj46NJ?=
 =?us-ascii?Q?Kz1b7E+LPRTQF7h5zfbHGv36mwHQPz/WPLmJvRgge1vmq9Gb0L7VTze1HYCZ?=
 =?us-ascii?Q?C7kSrk7apxxdY6KA741EC950hRsSqD752jiTizy8Lbv1fzEz3O0VCfza6P2l?=
 =?us-ascii?Q?/qL1fQ127TbPe2vkHhI06XUfxT+HdjAvqKBxyUIIPIt0cUJIEa57t7faD0TG?=
 =?us-ascii?Q?8OUOoPQ/CUqMnAFzwV4nKcRzHNyYGafaI6c1ada6BDS+Dj5HHhGHtyWKY3Kn?=
 =?us-ascii?Q?JtDk3Z6+HFGdXFetD50vKpTaSqbzh7ht8xiojO/+aqulHxC0KvtirwbcztD8?=
 =?us-ascii?Q?d6RW5/gOhoyDXu00koLLFVw1pYOCiuX/sCYgGRmVmQG/gXSgjxrL4OGm+1aK?=
 =?us-ascii?Q?6JecY2524KpllX14f4qk1cVlUVUSuDUIqQtl55AcQlusgUr+NC68z1WZN1ip?=
 =?us-ascii?Q?qD4QgpDS1smzp1bX+VXkps6wRt5UZGnQZVmTa5zkmdOZZEi43EScpouF6USg?=
 =?us-ascii?Q?0SBXe1w4ImJgMwAIfTz3QVD/MzInoFXL96HHJG9E+RZID3n2bqdpS+YTx7Oe?=
 =?us-ascii?Q?o6+jUDM5JPFcM6L/ZW/3mYVthxBYF8SXPXKkykm2+4GKnpaIKhNBxtD4b3YG?=
 =?us-ascii?Q?YOkAYdZpUyCnOdFrYoQmnVATL9Tknkp2NgrKFXngMzy7/3GbJQRGy4YZGLET?=
 =?us-ascii?Q?CqSAWWhT0hsgHJ2Fa/+1uN1xDswB5c9YmxRyWkETBW8nuNrD2uJscYVA0j3K?=
 =?us-ascii?Q?iN6VdIOhBe4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1317.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(7416011)(376011)(38070700015)(921017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Pa/qewR7iuaF4YZiUErz8+PNB/UE6pxf0nh10saCK3rihLh07WGlDMmHlIC5?=
 =?us-ascii?Q?pd+psq7w1ubFAZi2sx8DxhcQyprC/7EHB2o2+3Nfij2+WVSN3ZQysxvsvbmt?=
 =?us-ascii?Q?ykxFBg0oNgYCgVuy4x2OIFmZbSptVgrxymIS7iEVcUqYLOlDzFUl2JTRTwPG?=
 =?us-ascii?Q?eEEw4ZD5kYo4+mft4w/6ZgkEHj5x0d2ffXzmvDonNLQ62QvkSArd79eqHd3L?=
 =?us-ascii?Q?2IoRejJ0Zk3SvJf7jpqBAPzdCv1vHPSX86ytP7dGFX/rnpEd0JU5TuS2KE1S?=
 =?us-ascii?Q?xJlOM2cORRXkEm1Mj8yzxUb5RFR4Ywy9y+Pgsz+RsoqrmL4O8V6xx6BRoS00?=
 =?us-ascii?Q?6Id8vvI44jehNLF4s8hZvXeTF+Es5K5XKEphbKVjLEvOMqjBhgcOKIy8lKBC?=
 =?us-ascii?Q?E5Nw3hIoLOxLjBVGw8eXu37KUuSLzFEF5x3Ak+AF4ES3ulQDdToCgDcGfU81?=
 =?us-ascii?Q?pSpEeo5pwtUrav22R+jOXUqzxviLNXipwlZByc+1R6a8DlHZOzsEJJRyXajh?=
 =?us-ascii?Q?j5WO+wVjD5c+ytpH+gaY6GbLRJEeHIqnZ/ABldcbRUH2pW45mvFCxCfyaKw6?=
 =?us-ascii?Q?xaFsUn2zgjZqgPbFqhwWcfc/5GKq8CdrrcHl2FT3DDQVUT7wpXujyVXN6FxG?=
 =?us-ascii?Q?gJPYlrB4vx8jEY7tNRcWPTOdl20m9GkoS87AJq0k1/Qf6fZrn+d8KGF8HUKr?=
 =?us-ascii?Q?4IIhI8QtDLr/PwQGc5lHLojJg6ROb5kgLlKgAdu7vWbt1dD5EQe7Bw3MnFgV?=
 =?us-ascii?Q?CLg4sELucF4HBydxjeIj75cYQ4J70iOey2ISQlWd5DGl7hXadKvcXoGjkM0l?=
 =?us-ascii?Q?zTDhGLUEj22Om3Ghb26xwERbC3D15gYzWmceybFuRfDcGvAsHlzf4q2wGk5A?=
 =?us-ascii?Q?NU70zTgCOAJPUT7rdH2P7f/wFGZO0nEtmsKuAdaqPZ5tYrj0kpoyNbRGfPcv?=
 =?us-ascii?Q?E73KTLKoBC8dxcGCBFxoa/+N4ngQrbtu1ieopBcrxtzY9Bv3zmr9Y6lfBAHx?=
 =?us-ascii?Q?GgekyL5IHx8Ch/1b+xQwJTbxC6mFouBAdTC2kGlO6QcMswe5qcLdFx0RIKBj?=
 =?us-ascii?Q?HlvFGb8gSFdh+60yFzgJyhBxCIQZMX1stB/At/pLHyZbpSHbyIVDTTyn+s9j?=
 =?us-ascii?Q?T5oMx5bFQ6070DWRLIfbMI5cqBveqtbGb4QtXOuALFNPkdXGKdTMZHI5D27v?=
 =?us-ascii?Q?6AKOmfSQCpTUd9iPwDVVeUpoK6jJ3q39hG0IEERTXgvPnOpN/uwbkZ7E5TbE?=
 =?us-ascii?Q?pN8NKpmgW/uPvnyJqrLzqoGbQZV41NtY/3esIhoXRQZjLhCMsZ39+CMsZG4o?=
 =?us-ascii?Q?LdP5TYPGW1u3QeAQz2CRt5tNaW/faHfHyfJjd/FlU2GuAQ7OVtEaRKqZjbGQ?=
 =?us-ascii?Q?7efHJn9q5Kgyj5CjSuwUhuYNUF/U52JeLl0saOEYsxkA4x8gaeTtpixlNTXD?=
 =?us-ascii?Q?1Wlx5g836D6E5IprmWWxlS9Csgum9Xr1Fr7uU6N7VXNyTUudykcSIA84oTj5?=
 =?us-ascii?Q?jER0dDlR/LltKLAJXe68F0iOxUlgj4IxrjNqbjkL47egYZCVxfTFJozG2M/J?=
 =?us-ascii?Q?bVRBg1utA7mqtd9pbws=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1317.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f4c5920-5d17-4dc2-1a84-08dc917cce41
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2024 23:00:40.2055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HnpQpaT6OWAeyAGSjyCq5Izi/yzXgH5Q6LgxH2vK9Sxu77DP0qsO1uYi6CV+/v5UeFwMOIfpTZsvyuSnGkjrhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR21MB4495

> From: Michael Kelley <mhklinux@outlook.com>
> Sent: Thursday, June 20, 2024 2:19 PM
> To: Dexuan Cui <decui@microsoft.com>; KY Srinivasan
> [...]
> > --- a/arch/x86/kernel/cpu/mshyperv.c
> > +++ b/arch/x86/kernel/cpu/mshyperv.c
> > @@ -449,9 +449,13 @@ static void __init ms_hyperv_init_platform(void)
> >  			ms_hyperv.hints &=3D
> ~HV_X64_APIC_ACCESS_RECOMMENDED;
> >
> >  			if (!ms_hyperv.paravisor_present) {
> > -				/* To be supported: more work is required.
> */
> > +				/* Use Invariant TSC as a better
> clocksource. */
>=20
> I got confused by this comment, partly because I've forgotten the
> meaning of the ms_hyperv.feature flags. :-( Perhaps you could be
> more explicit in the comment and say "Mark the Hyper-V TSC page
> feature as disabled in a TDX VM so that the Invariant TSC, which is
> a better clocksource anyway, is used instead."
>=20
> >  				ms_hyperv.features &=3D
> ~HV_MSR_REFERENCE_TSC_AVAILABLE;
> >
> > +				/* Use the Ref Counter in case Invariant
> TSC is unavailable. */
> > +				if (!(ms_hyperv.features &
> HV_ACCESS_TSC_INVARIANT))
> > +					pr_warn("Hyper-V: Invariant TSC is
> unavailable\n");
>=20
> The above comment was even more confusing, because the code block
> doesn't do anything except print a message. The code doesn't force
> the use of the Ref Counter. I'd suggest something like: "The Invariant
> TSC is expected to be available, but if not, print a warning message.
> The slower Hyper-V MSR-based Ref Counter should end up being
> the clocksource."
>=20
> Michael

Thanks for the good "comments"! :-)

I'm going to post v2 with the change below.

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.=
c
index e0fd57a8ba840..954b7cbfa2f02 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -449,9 +449,23 @@ static void __init ms_hyperv_init_platform(void)
                        ms_hyperv.hints &=3D ~HV_X64_APIC_ACCESS_RECOMMENDE=
D;

                        if (!ms_hyperv.paravisor_present) {
-                               /* To be supported: more work is required. =
 */
+                               /*
+                                * Mark the Hyper-V TSC page feature as dis=
abled
+                                * in a TDX VM without paravisor so that th=
e
+                                * Invariant TSC, which is a better clockso=
urce
+                                * anyway, is used instead.
+                                */
                                ms_hyperv.features &=3D ~HV_MSR_REFERENCE_T=
SC_AVAILABLE;

+                               /*
+                                * The Invariant TSC is expected to be avai=
lable
+                                * in a TDX VM without paravisor, but if no=
t,
+                                * print a warning message. The slower Hype=
r-V MSR-based
+                                * Ref Counter should end up being the cloc=
ksource.
+                                */
+                               if (!(ms_hyperv.features & HV_ACCESS_TSC_IN=
VARIANT))
+                                       pr_warn("Hyper-V: Invariant TSC is =
unavailable\n");
+
                                /* HV_MSR_CRASH_CTL is unsupported. */
                                ms_hyperv.misc_features &=3D ~HV_FEATURE_GU=
EST_CRASH_MSR_AVAILABLE;


