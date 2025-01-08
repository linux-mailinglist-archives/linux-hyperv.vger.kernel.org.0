Return-Path: <linux-hyperv+bounces-3616-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A313BA06444
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jan 2025 19:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94A6316161A
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jan 2025 18:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A289200B9B;
	Wed,  8 Jan 2025 18:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="kBo/boaS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azolkn19011035.outbound.protection.outlook.com [52.103.12.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E80A1F37C1;
	Wed,  8 Jan 2025 18:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736360528; cv=fail; b=HCulkwTwFBR184ha/rO4wMCHv+/raigZP1lTmSvdc/fyQXYRDMgjPrPrxFZZUo135g5S4G8/Picr9KsMs9+O3qL7DFk2t2SmX5rB1K0kh9mk1+70RAAyn7ywXfj9zvCwaFv4lVYURXxcz3t4cJBKNURmDA0XyETCZz2subiny40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736360528; c=relaxed/simple;
	bh=lA5ekMuuxN4c7qQ+0WrgIZ9NhJ1JzBVmUBsmZxyJmbs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lwf8ayQ4mbo85X/3abWuVc15u+IGRxgLJLAokj/hnBYGFuFQDM8EaRMEPQ7nJJAxGNajwsje3Ar45en/PG3D4VWR/s+OYCOJX1ld88ML6z8Ow0i/VLPPxTzES7cura4042vDIbHEhe7Fqc7ZM9hRiHgiM8qJEJCQTquItnEaTi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=kBo/boaS; arc=fail smtp.client-ip=52.103.12.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uSK8UgDpcXxbAor2sCZHQIxlH75zo44vWxz1R3FoZ8AznZsbhs/STSZtNLVqMBqi3fHVhmtY/nYO2XKhDIwt8iLk+SxafWEjZWHOgxKHgNdkKtCDBQdStNjW6j7IN3JozKhDPOQaVa9JkJfk5uAEDnFfkSRNvB6yB5Mt37R1RthrimEHTn7DbzVYmOGBwQds13hJ+awJe643Xu3Pyx7XJQjSjRN9917ZIRDxHriB2qlA6oo7rOHtxfq9yfRfnPUePq2EqNQVsmCBr15ciKKq6a8zDhXyi0c8uREAJX71PZP+slC/xrsUJmnLq20tCPVD1ZYZGN273/Utj46KqKijnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Suhg9tk4p8kTl5xojNPLORDeBdSr4zSjp8DXZ17vV88=;
 b=bs9vwxEYr1SixzSselYlzE2kbpruepgzrasL75zZUIf2zQ7gcQt8+/xNqV3r0o66zWzO0zqDY8sxn9W7FdEcJU9v4QaFDm0AkSvTKGmAA49Zkf7N0aJr1CI0N1n8X2GPv3hUY3EF3HXV0NtXmnHxNnPrvirPmVNY5YyBBNpfQVFhpKNAuQvywoE+PrQ42gFNQxTC1Y/JW0NatDeGeLz2B/uxAO6jBjwbNtM1ubWHqj3l7SAhXXHwE0xrbfurnkwIEAiHNwawjMc4/fQty19igtGkb8ff0shmkKJzIvnrETPQwWpnpODD9iigq96poyyl2NYMdM+6iM614/CwjVsDbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Suhg9tk4p8kTl5xojNPLORDeBdSr4zSjp8DXZ17vV88=;
 b=kBo/boaSdzIv4aNbU4IFSUQVxjeiXom2CAtOVCwe6KPMtOzYxVJM6uDUMNP50ps1g++yta4HtMu6jo2Ax1fmaHQs4Mn32uLdfXlfZeX2wfsgCeXmht3lzJtGWBxVxk6z536SkT2eSVf1XO9YhhoDIRaSsOm/9yYF+liOHzGeWTG4W7xcJU9MDS4yaW7DF2TDMSh5Lvr7vxiSVaevk9o3qDPQ4UbbWR7dpuOo2GewuYUK/C0Xmad8939P1zcQTcXwTBG8GC8j5uxWAfUK+cnLwpZRFeCqkhc9dDW6w0qTk0m3BAvyhHxbJUr0gsXF3lYA6e+qYszOm7Ifxxnt8ikIKA==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by IA3PR02MB10470.namprd02.prod.outlook.com (2603:10b6:208:532::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Wed, 8 Jan
 2025 18:22:02 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911%4]) with mapi id 15.20.8314.018; Wed, 8 Jan 2025
 18:22:02 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>, Roman Kisel
	<romank@linux.microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"decui@microsoft.com" <decui@microsoft.com>, "eahariha@linux.microsoft.com"
	<eahariha@linux.microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "tiala@microsoft.com"
	<tiala@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
CC: "apais@microsoft.com" <apais@microsoft.com>, "benhill@microsoft.com"
	<benhill@microsoft.com>, "ssengar@microsoft.com" <ssengar@microsoft.com>,
	"sunilmut@microsoft.com" <sunilmut@microsoft.com>, "vdso@hexbites.dev"
	<vdso@hexbites.dev>
Subject: RE: [PATCH v5 1/5] hyperv: Define struct hv_output_get_vp_registers
Thread-Topic: [PATCH v5 1/5] hyperv: Define struct hv_output_get_vp_registers
Thread-Index: AQHbWuYC2DCvgIgzsku9OIIZyqWxALMKBg3QgAMx54CAAAQ8AA==
Date: Wed, 8 Jan 2025 18:22:01 +0000
Message-ID:
 <BN7PR02MB41482C89094DBC3E811C5918D4122@BN7PR02MB4148.namprd02.prod.outlook.com>
References: <20241230180941.244418-1-romank@linux.microsoft.com>
 <20241230180941.244418-2-romank@linux.microsoft.com>
 <SN6PR02MB4157F8C28BD92F36B27C9032D4102@SN6PR02MB4157.namprd02.prod.outlook.com>
 <7a60c96c-2fc1-411b-ac08-2b69f507af4e@linux.microsoft.com>
In-Reply-To: <7a60c96c-2fc1-411b-ac08-2b69f507af4e@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|IA3PR02MB10470:EE_
x-ms-office365-filtering-correlation-id: d89ccd26-8a52-4123-e209-08dd301158e5
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|461199028|8060799006|15080799006|19110799003|102099032|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?dUseBvtxB0aqkgmrOl2gIlTiwAB0RTQwWiHVVnaWgZnQ5R2j520cpz4Nsk/u?=
 =?us-ascii?Q?+lDYQASUT9JPAY4aTSoTe+6mNB8xGqfKpzVBxyOd81oie8JAjOv6ocD1iR+8?=
 =?us-ascii?Q?jWhLmALk28zsS4zKSmAxIQQwcN30w8suhkp/w5e5S/Iv1DtUMn7mbZFeaBvT?=
 =?us-ascii?Q?ldMAA64VCbvANmFneUGlRSOSz72F6V8dmpSMkCr0AT7YXcKG6co6h7oA/gxc?=
 =?us-ascii?Q?w6zb1bOyL/8fe+HEgJ54uimF5mCH8TcjkrR4U38ZxArdH1d1Ee3NOiv9nTr7?=
 =?us-ascii?Q?JV826LP8ZYMGxNGP3eQQcLyGHpOnE9JoAsCwYm1LR7e83pDKOGjyGVV4E+cu?=
 =?us-ascii?Q?JkV3vOGsroygcRpVfymyThHYEE7jN9JycsFWzfqpnNvsAorHe0Tu023UhkuL?=
 =?us-ascii?Q?KbYasm1H7lLTePg4paTo4OEEQ/S3Aj1QVCBt98Q/3IY89sbaQk4bawm9ytwD?=
 =?us-ascii?Q?Ir2UpspUVsnyPT9xKGEM22Fe1b6BMjXeNjOprZf9zuiZuB9x0q09lpkb0/fP?=
 =?us-ascii?Q?tBpFKH4SYhpvn72ryYFK4hvRNBy0HfDDWvCrLNQ/TODWfnWPX65BbWWowjK6?=
 =?us-ascii?Q?QirXaMYYgP4gSqgYmuaWvhK67lfQzvLX+iQbve1Z2yzOJ1/7d6CYc2Ft31Wl?=
 =?us-ascii?Q?0KlEpeO/vvVZdo0jPoyRa3IdXsWbwJvFvL2mi6D4Q78fP2W21VnxNQHB6WRI?=
 =?us-ascii?Q?pVxZL4eNPDi7Ef+acHclCn/9F05YiynWd27Z3yevmQ49/30aaNKPIBP6ek8/?=
 =?us-ascii?Q?EHHZYpEJ/DWhhi5KSZmQep9TBN03wPX6islxyBf3CiuJ1Lc6kRlkHJIyk2gy?=
 =?us-ascii?Q?onCMn5FRpIP4+nsTjUN6aUYqNzvTT17jdZBm3LngCnyDJP9GisFeyNnW2FmC?=
 =?us-ascii?Q?ar7gd5Ub6PKVYzV6XmnhN+TzS9j1TSFaFlqYNPmarDRd9cgycvGpeEMv+zc5?=
 =?us-ascii?Q?qCC/eUueXXSCqNW4aGTY3A37HUhgUW3/D3C94MhjTJt41/VhtuhiUkfQVwUV?=
 =?us-ascii?Q?0/LJJDHI+LekFjWMCP/KalPzWj9XzBJNdoFnBH+s9KTA/Lo=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LCVQUIlV70HjV/GSpAKjccXEoZOYAsWYgsfvrneWVdOcjVunU5jE1NVdcOy9?=
 =?us-ascii?Q?dF3XuzvK29SUVV2h8GKCOnXGEP28pgoFf3NIDPc2ZokitQB6Rjthi384xZKl?=
 =?us-ascii?Q?Gi9UZlEfNQjZtZYQ6zYZXUIssO8I/0YIFI7zbikYZDjgCTk8W+EHW/SWEA3P?=
 =?us-ascii?Q?XHrolVnJj+ur31aF3FNcmrixFp0XtvXPs0f6vytUVa8RM8uxuaFEdOilCXLh?=
 =?us-ascii?Q?iHfYtJ7G14wFwBq9N1t+ph3mh/pJOC4YcI6g/iJ4GRAR1PGOZfy+LvYiOnww?=
 =?us-ascii?Q?uRhqg+gvkqCZ8KJz/hfKqg53sh1Bth0edVdPkXLbM4IHDN3+PMcNJeoWTM1C?=
 =?us-ascii?Q?cixZcLro+Uyzfgba+78PzaKk5ckmpwNIxdTlDpdZrNqu0gzS5WmLWstPcwuc?=
 =?us-ascii?Q?0h0JbFpBWXqf0OorIfp1oXhTEYgLNW9M0rEdjQFDnhXzCvQyjdVKxHCNk/Db?=
 =?us-ascii?Q?n72x68o0ao7PMLlg5Er2UL4x8YAn7WQtQRiX10AnOBbR9sWLuFdpTW+QzS7J?=
 =?us-ascii?Q?lpr7R7SMLGs/1nFeUGqEqNTAApj7c3fVd2CRGIdTKhfMlEHZ6m+GFLPsleVd?=
 =?us-ascii?Q?03kyFZQ8j5/JhgRvJARfuvd4Xq3HPuAMqLyVnXMR96XkT+rY1ffQ1igWl9JS?=
 =?us-ascii?Q?V3nEBDwGLk+qW4Ii7egxYBKi8OX/WL2HyXLWhP4izKJ/ZugKgzDQGRPGP2yO?=
 =?us-ascii?Q?6AVLhI3C+gbK6eid7RnuXOV24Js6EYsJKfZNaK9jD/ze4cb1j28RdE4O27qy?=
 =?us-ascii?Q?yMqIa6ECBLDU2a29WyV/6SwMcWuRSWcXejN+YV8fM8QXS7wd5jRfFnf3EBab?=
 =?us-ascii?Q?2ACGH5/jQ3+9dV/w4yK0e4RaPKr8iDEeXnY7LOn2inQL7oPLEHXxnnnQn8xf?=
 =?us-ascii?Q?aiyIHVsAuEoyJu23LkCKX0wRzrrk+hR8Eg9PK23uKonZY4hot2e6Ng+T3pht?=
 =?us-ascii?Q?vv4bBsj5HsQFJSbeGy0RHKMOdxROGjcqOsA+kL4ElfEMPkwLPOgKIFGScbNE?=
 =?us-ascii?Q?FoZk9Kieo5feowDhzBte/m76CRxwy9YA84d/sNT0ffEb1E60CVAMck1h7gvj?=
 =?us-ascii?Q?aI6E9DiLZDp61qdj1+jKaWgXmM9sM8kAmhJ7JdsZvQ8vggglyIFtDCXdKvJP?=
 =?us-ascii?Q?NnNxUURqJkTAc8UowFAUGQ8+XDJ5/qP6C4QHya62Ef45bfRiMnfCSzi6v+q/?=
 =?us-ascii?Q?z14BJLir3tPerfkyYKqANH13iLrWQIbtHNDFRs6MbYGPonth2tDIKyg3gTg?=
 =?us-ascii?Q?=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR02MB4148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: d89ccd26-8a52-4123-e209-08dd301158e5
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2025 18:22:02.0254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR02MB10470

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Wednesday, Ja=
nuary 8, 2025 9:58 AM
>=20
> On 1/6/2025 9:37 AM, Michael Kelley wrote:
> > From: Roman Kisel <romank@linux.microsoft.com> Sent: Monday, December 3=
0,
> 2024 10:10 AM
> >>
> >> There is no definition of the output structure for the
> >> GetVpRegisters hypercall. Hence, using the hypercall
> >> is not possible when the output value has some structure
> >> to it. Even getting a datum of a primitive type reads
> >> as ad-hoc without that definition.
> >>
> >> Define struct hv_output_get_vp_registers to enable using
> >> the GetVpRegisters hypercall. Make provisions for all
> >> supported architectures. No functional changes.
> >>
> >> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> >> ---
> >>  include/hyperv/hvgdk_mini.h | 49 ++++++++++++++++++++++++++++++++++++=
+
> >>  1 file changed, 49 insertions(+)
> >>
> >> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> >> index db3d1aaf7330..e8e3faa78e15 100644
> >> --- a/include/hyperv/hvgdk_mini.h
> >> +++ b/include/hyperv/hvgdk_mini.h
> >> @@ -1068,6 +1068,35 @@ union hv_dispatch_suspend_register {
> >>  	} __packed;
> >>  };
> >>
> >> +union hv_arm64_pending_interruption_register {
> >> +	u64 as_uint64;
> >> +	struct {
> >> +		u64 interruption_pending : 1;
> >> +		u64 interruption_type : 1;
> >> +		u64 reserved : 30;
> >> +		u32 error_code;
> >
> > These bit field definitions don't look right. We want to "fill up"
> > the field size, so that we're explicit about each bit, and not leave
> > it to the compiler to add padding (which __packed tells the
> > compiler not to do). So in aggregate, the "u64" bit fields should
> > account for all 64 bits, but here you account for only 32 bits.
> > There are two ways to fix this:
> >
> > 		u32 interruption_pending : 1;
> > 		u32 interruption_type: 1;
> > 		u32 reserved : 30;
> > 		u32 error_code;
> > Or
> > 		u64 interruption_pending : 1;
> > 		u64 interruption_type: 1;
> > 		u64 reserved : 30;
> > 		u64 error_code : 32;
> >
>=20
> Agreed. In the spirit of matching the original headers, I'd prefer
> the second one. But either will work.

Matching the original headers by using the second one is
fine with me.

>=20
> >> +	} __packed;
> >> +};
> >> +
> >> +union hv_arm64_interrupt_state_register {
> >> +	u64 as_uint64;
> >> +	struct {
> >> +		u64 interrupt_shadow : 1;
> >> +		u64 reserved : 63;
> >> +	} __packed;
> >> +};
> >> +
> >> +union hv_arm64_pending_synthetic_exception_event {
> >> +	u64 as_uint64[2];
> >> +	struct {
> >> +		u32 event_pending : 1;
> >> +		u32 event_type : 3;
> >> +		u32 reserved : 4;
> >
> > Same here. Expand the "reserved" field to 28 bits?  Or maybe
> > there's a reason to have two separate reserved fields of 4 bits
> > and 24 bits. I'm not sure what the register layout is supposed to
> > be. Looking at hv_arm64_pending_synthetic_exception_event
> > in the OHCL-Linux-Kernel github tree shows the same gap of
> > 24 bits, so that doesn't provide any guidance.
> >
>=20
> Hmm..these should be u8 bitfields according to the Hyper-V code.
> However that leaves a 24 bit gap as you pointed out.
>=20
> In the Hyper-V code, these structures aren't actually packed,
> which means sometimes the explicit padding is left out
> (unintentionally).
>=20
> Please add the 24 bits of padding to make it explicit here. I
> suggest making the bitfields u8 as in the original code, and adding
> another padding field after, like:
>=20
> u8 event_pending : 1;
> u8 event_type : 3;
> u8 reserved : 4;
> u8 rsvd[3];

I'm good with that. For the ABI between the host and guest, we
*do* want to make all the padding explicit.

>=20
> >> +		u32 exception_type;
> >> +		u64 context;
> >> +	} __packed;
> >> +};
> >> +
> >>  union hv_x64_interrupt_state_register {
> >>  	u64 as_uint64;
> >>  	struct {
> >> @@ -1103,8 +1132,28 @@ union hv_register_value {
> >>  	union hv_explicit_suspend_register explicit_suspend;
> >>  	union hv_intercept_suspend_register intercept_suspend;
> >>  	union hv_dispatch_suspend_register dispatch_suspend;
> >> +#ifdef CONFIG_ARM64
> >> +	union hv_arm64_interrupt_state_register interrupt_state;
> >> +	union hv_arm64_pending_interruption_register pending_interruption;
> >> +#endif
> >> +#ifdef CONFIG_X86
> >>  	union hv_x64_interrupt_state_register interrupt_state;
> >>  	union hv_x64_pending_interruption_register pending_interruption;
> >> +#endif
> >> +	union hv_arm64_pending_synthetic_exception_event pending_synthetic_e=
xception_event;
> >> +};
> >
> > Per the previous discussion, I can see that the #ifdef's are needed
> > here to disambiguate the field names that are the same, but have
> > different unions on x86 and arm64.
> >
> > But on the flip side, I wonder if the field names should really be the
> > same. Because of the different unions, it seems like they couldn't be
> > accessed by architecture neutral code (unless the access is just using
> > the "as_uint64" option?). So giving the fields names like
> > "x86_interrupt_state" and "arm64_interrupt_state" instead of just
> > "interrupt_state" might be more consistent with how the rest of this
> > file handles architecture differences. But I don't know all the implica=
tions
> > of making such a change.
> >
> > Nuno -- your thoughts?
>=20
> My main preference is to match with the original code unless there are *s=
erious*
> clarity, style or incompatibility issues. I don't see a big problem with =
gating
> or not gating these. As you pointed out, it *may* make arch-neutral code =
a little
> more cumbersome. But it's hard to say if that will actually be a problem.
>=20
> Right now it seems to match the Hyper-V code and seems fine to me!

OK by me as well.

>=20
> >
> > Michael
> >
> >> +
> >> +/*
> >> + * NOTE: Linux helper struct - NOT from Hyper-V code.
> >> + * DECLARE_FLEX_ARRAY() needs to be wrapped into
> >> + * a structure and have at least one more member besides
> >> + * DECLARE_FLEX_ARRAY.
> >> + */
>=20
> See below - you can remove the second part of this comment and just
> leave the first line clarifying this is a Linux-only helper.
>=20
> >> +struct hv_output_get_vp_registers {
> >> +	struct {
> >> +		DECLARE_FLEX_ARRAY(union hv_register_value, values);
> >> +		struct {} values_end;
> >> +	};
> >>  };
>=20
> I missed this change from a previous version - the additional empty struc=
t
> isn't needed here.
>=20
> Michael -=20
> The documentation comment you mentioned previously[1] is just
> describing how the DECLARE_FLEX_ARRAY() macro works - it actually adds
> the empty struct to placate the compiler.
>=20
> See include/uapi/linux/stddef.h:47:
>=20
> #define __DECLARE_FLEX_ARRAY(TYPE, NAME)	\
> 	struct { \
> 		struct { } __empty_ ## NAME; \
> 		TYPE NAME[]; \
> 	}
> #endif
>=20
> So the definition should just look like:
>=20
> struct hv_output_get_vp_registers {
> 	DECLARE_FLEX_ARRAY(union hv_register_value, values);
> };

It was actually Easwar who mentioned this. But regardless, I'm glad
the simpler definition works!

Michael

