Return-Path: <linux-hyperv+bounces-7253-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC76CBEB3A6
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Oct 2025 20:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53401423265
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Oct 2025 18:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9382FE577;
	Fri, 17 Oct 2025 18:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="FQPixT0Q"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazolkn19010018.outbound.protection.outlook.com [52.103.13.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB9D257831;
	Fri, 17 Oct 2025 18:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760725947; cv=fail; b=CwgCXYb5TInLcuaduC6J6rGdMVka+jyGAEhCzq868njUHKYVliYp/RJWMUYhTDp5wulEXQ70z6vSU0sgn9Rc7u3qcCUa2hOdCILl3MLSkMBTsFfpOb7hL3w6Fh9owEPcn3dn3eZmIKxFsKMc8ozzxqn3swCRlCIQrWtbUCvloSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760725947; c=relaxed/simple;
	bh=65ZmOGtuUvvtQ7quilqBJXJea4QDgQZBes1yLNLYX+8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ng8Ay3T6VKi5/hcVofiW3TjmMW91l8AGeUVjdwiCUqDC1nSmtCDXsAEQ+fBC04cP/3P9modMo8fhJXo8JPB6aK79iWl2lL0GX+Dr698RsVC7QSx2MpjpbaNDGUKf0TL9YNEuRxVqTSCZOkXiZ8PNXdXwTlBmywNb3/rzpCB/t28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=FQPixT0Q; arc=fail smtp.client-ip=52.103.13.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BQgwpiUYHQZKGDx2ZSuZ+Ff3ftnPZf/SRmS/JJbUyLpBASXDZCQG7/CJjbJ2m5aH506d0FDtLFKNZX5JhaJk47yBZxFCHONWxbhjFMUvlAvtQ/RvSAFtAK4/eSyzZeGtkIC7Qw/8diw7F7jmaA0KEuXgTxQ1fHh1KOYn6c1E1fCK6zzWwzHWrU90w5Nmfq3KPXcGA2FYV9MfUOEfHPzbIl09yfENWmBkBhFDuafU37yVSDFeEUm8Bj7Mvx9MVoCB+t9CWcSnbKpLwTxrOSJfRV4rqyP7tmkjACfal01D/PUFAYLLNzJDjGRsGzQ5EWf6tGkN7lNQemgPo5Iek/4M2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yPDjLWJq3JX4nhHI6Q8HUB1P8DnRAfMt9ln+S//BJH8=;
 b=T7Tqyknwf/7lXho/E9lUXnaCPrBMtREiHYlVScKy6qiffAtqHhJUVKerwmFPq9ZtAM4Jc3koIa4RzGf8WmHd0KWekqY9VDMm9W+dtb3TDVhm6WjTEPbeGMoRj2FfDICV+Wt4D66h78q4wCl9fdapSjh20Lo1AZIJ2NtEDpBtigARL0LIpdw8+flqSPquD9asMOv1N4c6tBKiVQ1z+G+mq45rIBlkcBoM33noo26cuhuC6e/j9SkMRD82Jqe5GtfgO8fo7kp5r2Vfn5pgsrYekeAGH72PCeT7JYgxM3Ta7+rFDzZHeYRimYi01k03m7Z6zxOUkpPbFocq6jsGvb+ePw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPDjLWJq3JX4nhHI6Q8HUB1P8DnRAfMt9ln+S//BJH8=;
 b=FQPixT0Q0KiWxKXiDo0irpzO513MIaTyKIZFCStKFZGmhVY1+jHHVzvIkZ4cFopQZfnK8++GeDDWfK2kM8YqipzyvTrH3xtlH8Bj/e3RaNHntqJp4Cji7f9LsEKZEkCjHuUgfJ9ImpuzvVBWvY0I/OsC9rl27Fa4WMY8gK2jmzQePcSEaO1phNJLYhEnz+0rTxKD9dmFpzM0VoY5rBJGhtrXl0zJzUntmeG2h6EJGHmjsEC51R7eXH8uEwKmHGNMWtg40EDLlbNJstFiIHsZJFVrgl1TXpaPd5+m007ymVCAjr9s4YmSeojEMJffIVC3zp1Gd+2jZkFFce9uahD5tQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DS0PR02MB10251.namprd02.prod.outlook.com (2603:10b6:8:1b4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Fri, 17 Oct
 2025 18:32:23 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 18:32:23 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, "K . Y . Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
	<hpa@zytor.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, Mukesh Rathor
	<mrathor@linux.microsoft.com>, Stanislav Kinsburskii
	<skinsburskii@linux.microsoft.com>, Nuno Das Neves
	<nunodasneves@linux.microsoft.com>, Peter Zijlstra <peterz@infradead.org>,
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Christoph Hellwig <hch@infradead.org>, Saurabh Sengar
	<ssengar@linux.microsoft.com>, ALOK TIWARI <alok.a.tiwari@oracle.com>
Subject: RE: [PATCH v9 0/2] Drivers: hv: Introduce new driver - mshv_vtl
Thread-Topic: [PATCH v9 0/2] Drivers: hv: Introduce new driver - mshv_vtl
Thread-Index: AQHcPzoJMzqmW110LE6lOXd0cAOXarTGpwrg
Date: Fri, 17 Oct 2025 18:32:23 +0000
Message-ID:
 <SN6PR02MB4157AE454F412993BC1D4BFDD4F6A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20251017074507.142704-1-namjain@linux.microsoft.com>
In-Reply-To: <20251017074507.142704-1-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DS0PR02MB10251:EE_
x-ms-office365-filtering-correlation-id: 380f8994-e108-4dc9-482a-08de0dab839f
x-ms-exchange-slblob-mailprops:
 98ioH9+sI78sQVScH9arnL7JKFhHzd4QgySgkyxoreLS/nzmfjD3ud0hYvwYqYEdtoNCE+UduKlpXybcrU5TJjZVEkyiDS1vFup6EN/z2y7oP9bFLSQwpr4y3kzosY3ZxbKlehdto7ZnzU4aMUJD2DvcMLs/Ip0SfqlgKPdZkuZ8g4adMbT8ISeBpozDhDePR/MDyDT8x2OynFqjTaEDHIb0o1BxtPpw5lYCvl0dyLwhx0720hSJefUDNznbQ0ZRfK3BDnaKgZ+x4MH94efTSzHstCaKerJgzK7jrblJBJcxGCCYH42A0z3ETyv/Z52Hydb8b+ekIYrzf7kbx2usEN7XLv7oEEP7bfPpoQDZ4gAOn9xfT3Hs455gK/dZtcp1oN+pkyYM9uI0KBFlNTk0wvbP39vrVy3R1CvpC/6pCTzHQuFO7POr7ZZAnqbjHytr+SeXZwt1VTvwh+bzflWZPFcaM3DIYyiPwPCyoBMTrdZYJ5VwFDTR5e7sl20ZKt6O2wV0B/7hG70rAMbxRR01rC33/7Vo2jr0FILnG/KU5dJaHQcwIo4McolXGpBIgEx//EIPFEPvV+oVq1S87oKgd7r4ilq0hLM3w9V1Mi0M8bXper9CzPHHMhAu0kqdRT04rgDxNk/XYxBrR9F0PnRbdIK6cJbuN5w0argu5BFCswaYgkgnAPwzoRqa4fVYt0NAWp3BWUXVo46F4avrGQCApY+hv5DDWS/Rp2QIh8tsearCltjQGUHBi1UiBJ6KG0UnNnr9JjtGt0iFkQMWYEqJ8NznSbTdrGWacbKJXAbiUTs8HI+t4b4/G0xOGW7CRsBdP53/nBV5cNB7VE4wu7ip2KUwQcIvfMQ+RXAoxpHkmzqJF2PuzLKI8A==
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|41001999006|8060799015|8062599012|31061999003|19110799012|13091999003|461199028|1602099012|51005399003|40105399003|3412199025|4302099013|440099028|10035399007|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ur3jnbJRWe3F564fhK59vYNLZHm3tSBdZ06U0NIKbhADWHY0gDUYLurVbiTh?=
 =?us-ascii?Q?wWK6iNbLpudSJuSCVfc6pM1/rv1g3DWbk6wbfQfzwISNFpeZD0RMtdgNxzZ8?=
 =?us-ascii?Q?UCzJVJ7Fuy0QaxdnMQKdgYn/vj4jtd0MTDunlRNiKVbM/KL1ALbnPAIVqiVa?=
 =?us-ascii?Q?SyGXb2zJSzGqo2u3VAwDhdwUBFEsL2ALlHzC4KBtBcuIW1soJnEFBnrWG+0Q?=
 =?us-ascii?Q?un9+NUaebZImQP2bT686uVga0pdcf8md6Hwk2mWz1iqPygH5VcUN1UwH5oxV?=
 =?us-ascii?Q?PI+nr+hfsHvQuJZmXp6VELfXE4t6ubKxbuWDGOc0iFzyFEJEFnzC2TqRbtMR?=
 =?us-ascii?Q?d2IMJW/AF93+VMYiWuOy67+Tv6qR9qTfvp7JyCiJ5abFzszVDKXqpCobqCap?=
 =?us-ascii?Q?B4h66XIYvw3A7aRiybgpbn4I0qm1i/x31V3VZ71sJ6ZZM3aoYgNbmvrKcO+K?=
 =?us-ascii?Q?XcGjeeoWLpZ6A8ihv9HXhPDEu6Y5UDRn4sZ8J34wkgOMHTCHWR4lq6hzAIaV?=
 =?us-ascii?Q?x7PsFsbjjqT4ek1n0lgNQ+tuIOCInJK7Bc9QKgTGiC+dmgp4bNL5z5mB7ZRQ?=
 =?us-ascii?Q?NyBYAjrok2hOq6ElE+pwXiM3RXGTIcwIA3+NkELewgucl6wa4r5pKwjjq0wh?=
 =?us-ascii?Q?bi1PUmzIBUoV8p3GmG0Uw9aCisctGflxi3SmBRseQDNSkUoXMCbcB9It9J9K?=
 =?us-ascii?Q?ubsfHPQZ0gxd1mFeILYNBWnI7fAXl1+Ov4oZUkzojni4xqXEfBNtgJ7QAbz0?=
 =?us-ascii?Q?dQK8Y33RWP9bO6X5uw1Vr+RVYGZOcY1iOSbIpHfFC1SAoxRv2DUXMgvauZSB?=
 =?us-ascii?Q?K6OCjEGAmPj0EWumOJxmRw0EAfKaKCoO5FjxrelcKbEbmhDxk3Ez49Y/jxLS?=
 =?us-ascii?Q?9FgJsRz/6n1me3QHHP8Ow8ZXp9DqFz8fsbuvHqvvCipNsl7JxczYfJV9BiGy?=
 =?us-ascii?Q?QMr9mKMFDR+ocH32aw37YnqPrfx43dOQtFbTbJROFAaq1iaxuDJ98NDPcZ83?=
 =?us-ascii?Q?010YRWFxy+W0SRViy+JNOgwa8BiJTiBYbdXMEClkmoEwdkfzm3aVtbveBI8Y?=
 =?us-ascii?Q?7jsJr/cI7K2qyG/jVw59ZkP97LNlxH88qz2dxT2gmn650bpSqXF/3ios3Rz3?=
 =?us-ascii?Q?BS7f71qStUADQNm0T087T93N0GAsOrtpqENvz+t0wL8ujfBwPlczTmVt1x8I?=
 =?us-ascii?Q?uKNgoIcTFctzsT79uKI3gt/CUCFoHICCeRG1hoCAndI3kOl0U0NVak/G7cy4?=
 =?us-ascii?Q?vQHIGUrGYWnKyMKpZyLURzL4ngXobjavcuD5e5pyJ8jPm/MK+eKyS2o1tWXA?=
 =?us-ascii?Q?FboV6Z7Y8TZdNjRs18Di4dVU?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?uDTv1AC5E+b0co9P9GOH9piPoIhl2nJ39FCgaAIvfv44mMljsgKfLPlTvu72?=
 =?us-ascii?Q?u0QKrSRT5xNdF7fI36oi6HQDxBygmO1dwxg9Mn0PwBE6pHGAMXdHT+6gjqMo?=
 =?us-ascii?Q?JHNqeVMaffE1iKcF2Ex5FW8J2LsIevPm06Krw4xpMqf93x3xLSShqEydPWJ7?=
 =?us-ascii?Q?vKh+51CqjIokyVmROU+xWfr3rH06mXwRF4de5O2DfcRfhoHeXCXOJaRKrqb5?=
 =?us-ascii?Q?NzH0yg0HxPeLEh6re5anAbYY4VK0EL1FHq0Fb3xFgJDw+GkcV7wz3waFDiE+?=
 =?us-ascii?Q?ipxjFq3RDhgGIqnRW63w//TX4ypgAnOx5OqKfKBiIGum+kHZwnBkbQbJRdyr?=
 =?us-ascii?Q?gPyFKvP8r/e9WVDMi1GN3WRTFvigNTTY5L5wwg9+S4Ph1fg5DsjpYoVyTXT9?=
 =?us-ascii?Q?qzzHm6GTPIDy+v3A22yEOoDMg+USC3U5tWq108C65WSwvAyha2xhNhYdq/Ob?=
 =?us-ascii?Q?4iF9lfblm4N/Er4ZVCWqgBpfKbeAR1/DpQcHty1oNgDatnW07ax7clo1mH/M?=
 =?us-ascii?Q?COie4aclv+6zgjUVz8epDhzlw8h0wqdONzK0QJYzjq5/ekgifCOgrYB9ZD2z?=
 =?us-ascii?Q?2GsM+EAy309O+ngw5cAU3BjAJD5ZK/nHkkWjcT29K/C3SCjkA4CgZlbLq7Vk?=
 =?us-ascii?Q?2VvsRbl7KyrUGPDix0cF/5o04sz74o7QGtJql+U4tGF7eh4wIBHCh4rkr51q?=
 =?us-ascii?Q?2Mg6yjJ8iPOLefw7jJ0gEdwvxof7WmMavv5LacpHbJGSQA6PL2wzxmFFWIzO?=
 =?us-ascii?Q?pNk4GDCfeHlc7XBP07rihdf0iSURQKLgsb/xUVrozcN1mxVKnQyJ5BUOGKK+?=
 =?us-ascii?Q?XPihPGoGvosQOFLYRfGD2LwhPfLeJBaiSij/41BM7uYFlv/9SF04KGqNbF3r?=
 =?us-ascii?Q?802zOKetM4ziOBagvwK04WL2BL0MQP2MTQeJsNUjMSM3hvwFrWLLtlUTRNIE?=
 =?us-ascii?Q?af/wYKqh7M3tKEFE4OmwY8fW2f6gh2IJLJR5Ca3U1D9mQBkp6yY3Icz6J4GE?=
 =?us-ascii?Q?JIF/MjA7cO6rFkk9NX6Rwj2xLaegY6vG04SG4YS8Ka8DSb6Jn19Zw71lGk79?=
 =?us-ascii?Q?Mv4E7CpR+/MiUWHcanAHkRhqQ88uBOgdaN665Bdrw9Pkl7UK+WXD3qL+8a9a?=
 =?us-ascii?Q?XlgEOI+InOBnTLXyRiCYOTNh6HXBNPTlRjmsRVlQDQbBOOstp8V6asrGbUxB?=
 =?us-ascii?Q?gbP+J0VsB4MZsbVqd9uHwn91+iA5X3GbwIhP/u8i26/lLeAeDpmcOjOTD00?=
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
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 380f8994-e108-4dc9-482a-08de0dab839f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2025 18:32:23.1740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB10251

From: Naman Jain <namjain@linux.microsoft.com> Sent: Friday, October 17, 20=
25 12:45 AM
>=20
> Introduce a new mshv_vtl driver to provide an interface for Virtual
> Machine Monitor like OpenVMM and its use as OpenHCL paravisor to
> control VTL0 (Virtual trust Level).
> Expose devices and support IOCTLs for features like VTL creation,
> VTL0 memory management, context switch, making hypercalls,
> mapping VTL0 address space to VTL2 userspace, getting new VMBus
> messages and channel events in VTL2 etc.
>=20
> OpenVMM : https://openvmm.dev/guide/=20
>=20
> Changes since v8:
> https://lore.kernel.org/all/20251013060353.67326-1-namjain@linux.microsof=
t.com/
> Addressed Sean's comments:
> * Removed forcing SIGPENDING, and other minor changes, in
>   mshv_vtl_ioctl_return_to_lower_vtl after referring
>   to Sean's earlier changes for xfer_to_guest_mode_handle_work.
>=20
> * Rebased and resolved merge conflicts, compilation errors on latest
>   linux-next kernel tip, after Roman's Confidential VM changes,
>   which merged recently. No functional changes.

Did your testing against the latest linux-next included testing with
CONFIG_X86_KERNEL_IBT=3Dy?  This is Indirect Branch Tracking, which would
have generated a fault with your v7 series and earlier because of the indir=
ect
call instruction when doing VTL Return through the hypercall page (which
doesn't have the needed ENDBR64 instruction). But now that VTL Return is
doing a static call, that should be direct, which won't trigger an IBT faul=
t.

To confirm that you really are running with IBT enabled, you should see

[    0.047008] CET detected: Indirect Branch Tracking enabled

in the VTL2 dmesg output.  And "ibt" should appear in the
"flags" output line of 'cat /proc/cpuinfo' (or the 'lscpu' command).

Michael

