Return-Path: <linux-hyperv+bounces-2409-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2FF905FE5
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Jun 2024 03:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E0D61F21FC0
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Jun 2024 01:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539F320E3;
	Thu, 13 Jun 2024 01:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="c+d2pZS8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2014.outbound.protection.outlook.com [40.92.42.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F898F62;
	Thu, 13 Jun 2024 01:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718240484; cv=fail; b=JTlap/4D9HiJLp+abM3jcGoJQ2BQLHs6ye4823qn+ecJtX4oy8NjhsuXcbJNoQqrkdR26nFyyqNCzGeU8t9s0Lz4UWvalqzoTDgvJX+7ssnJ1bWuW0NcbQgwsk3yXcFjpovLfvRT1CFmI8HSN2Du5vtSLyRU1zqmvsLlH4dImxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718240484; c=relaxed/simple;
	bh=o3rCOBA3qupSRdPMC4wDZoro/howIlDR3H8fMhQK108=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fXpbW3tKFVMM0ZAIHtGTtFZVQIS8M/y5OqGTyQJcCeI0hvDHEZCQolMPm2jyCpCFtl/wB5QcucnajpDFi+KurG2uXDvSiPo1L0YaSwWOz4Hu6HBI8QhgsrsXVZ3RysHMrmogNrfMg6FaOf0l46kiJ6EvG/qOu2bICAkr3DSuWdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=c+d2pZS8; arc=fail smtp.client-ip=40.92.42.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQe66JkKVctTxmUk0/GStWtsmuEUYDAmp2fUe8JHP4V37Ogw1xqMrmtuvgNqlUvusgGiFZ3EdkYJAcFgj/oKQed6eXrQ2N3p6vFalzs29JPW3lgOJaZm+Q5vAvvBNRD79tzgpPDiSmBaA+dmxYfsPQwBsZv68hsNt77i/Na1dYsd+k/y/yU2B01thsczxznamN3yuCYiOiyOmKuDkfu0vXFUbwlwiTmVx8QUDITzhlgz/7ZdzTidrpVZEGzavN+jGQsKIIbFTluuB6XX6djZcGcCQlO8TwXFtmWsJfvPX7pS62Q3a4rDchSr/N3o6MoDISdMekP+fKC77wGDntxdzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vjZRgSD0JDqASChwMK4iAf/lX6XO66PXuvaqgvV9OYE=;
 b=J8ECmiwsucWZSCN1ZbPtbQDsRHt3PRtmoGX3DaBdHxs1D8iEKVFABkCCKAqNdz/ppR6p/zFz7pjKcZNuMJjvmc2dhxyZzU/812mRe9HYPri4VI+8eAnd94bmlSx0fQf/T0Oc7bP2nBHy6n6wLqyjWghM+RYR6aXDP1qrboqUY+RXSzIjXIytGi03i/0xHiIqd6QGgGhaOV47H9PhoqsawqSgoOn1qaEplyjURFDqy2o6aZTrwRaBWOgthWig3D6qMgMxuC059hgvfV5hxgp0vKXftGJYQ+0LXPH23GDaDSziBVRe7e4DkYMj5aSEOVBZy2HrgiYcEFRytAFpUKE0ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vjZRgSD0JDqASChwMK4iAf/lX6XO66PXuvaqgvV9OYE=;
 b=c+d2pZS84ubp149UGd9DYqvg01j/tH82q6qWja4/vJe/QD1XYf5AhYfi4SBLml7IIxbE0skCQUbvSw4Miyu/PC0F7+R53ndDI/mnR+2p2rHNSDV5bJY9ibz+3TuTOFYJuX0ADvLxXXWQbGOZGEGdOL+pNMpuVYxIFU0ml//1j6l/JqAu5Fqf2ft9RFzPAFwNh19mraXzLkluNLVP4P/9FBGfvUGnb8Osa4q0tR/Y5XvBjEgiqPSQXFuKWfQndAmJ8HsGi76Ggr2ST3S8MUsGOAnUnypEerO1SW1MGViTWfP+vzRxsLv9ueFcyDncwO7ySnWacIFujhyvItNQFDigew==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH2PR02MB6522.namprd02.prod.outlook.com (2603:10b6:610:36::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21; Thu, 13 Jun
 2024 01:01:19 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.7633.036; Thu, 13 Jun 2024
 01:01:19 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Easwar Hariharan <eahariha@linux.microsoft.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: RE: [PATCH 1/1] Documentation: hyperv: Add overview of Confidential
 Computing VM support
Thread-Topic: [PATCH 1/1] Documentation: hyperv: Add overview of Confidential
 Computing VM support
Thread-Index: AQHau3TUvOHXX6OB+EKZI1Zfm6ByWLHETxSAgACQwaA=
Date: Thu, 13 Jun 2024 01:01:19 +0000
Message-ID:
 <SN6PR02MB4157CA088C0F84C8B72C8EE3D4C12@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240610202810.193452-1-mhklinux@outlook.com>
 <cabdb509-83a2-4de7-8e10-4eea7e4c96f2@linux.microsoft.com>
In-Reply-To: <cabdb509-83a2-4de7-8e10-4eea7e4c96f2@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [XxqY/4Lwqq0UUN+GDg5J/O8bvCqO7WD0]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH2PR02MB6522:EE_
x-ms-office365-filtering-correlation-id: e2170da5-52a7-4272-a27e-08dc8b4455f2
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199022|56899027|1602099006|4302099007|440099022|102099026|3412199019;
x-microsoft-antispam-message-info:
 +ohc+odWdjFc05BbjRirdwPeqQY8IqM1xdmNQ5KE4zKxSPpYQiBs881a0cu/oS5YyPbuunbJhRfzqLKhowRgDzr4UH7gDpnHl4Ayya6CXvlP52x2aS/C282z4yvLVdFOELxXI2rjFsK/q1PXnVQuWaDaFaRpckPDQTONhEbGJ6ZWEOxBHf2YjYfso/G5CZiCXy0+K2GxC4eSrGD3/PQEf+nrtKw9vbTjgaEWCGC3/EjBDgtDJ7tPeeHJpxsAOmwsSeVdSfAqSo5EwsbnmfH6vSEOeKBXBxx3/AkDIoVOgZHxeOY8NTWnI2AXnH46KQMS1p4fhnNtq3l5Sesj5ML4xJQ0LuW6PQZwCtUCyKAtKSuKnkrWHhDOU0WbNxp0RzAdgpNWY74z7KOxLN2iHygsFNb6K3WpsjrSVqEprXnGOBTeEp5AZlAGy7oQTadlpJfUy0lI3g6snuib6iLP8RNiH8QgPP+7QPa98pvDsC7Dfiy1aTzw8ZzkLzGhcCCSAcyvaK2oazQV8XCsejlK8l0M6FiCd3hZRH/N2lat8jw/E3iPI365UiBjPd0ZlZXwDKDdgjVcFUPgKeDXbahsrHRimj3nb1dHhfazyijrx6uqZRVBXQV/OWsLgVSb6niRVRLSGy2xEmXfWrrYlxG+D2RFsWyWTPZThDaNKMqO4ffj8MhmDonPBvYr9m7oRBght/dG
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WmkLZSMt1zd5QRN6bwhlV4WTLN7pgNeL+yU5ZXYUF0mfDKRxUku1QcGD3nmM?=
 =?us-ascii?Q?uG2NADgPDp7pVW8U6io52Y9WY/mpg4dmaL4AWttjmbRrnStGgvaNovpBaqT9?=
 =?us-ascii?Q?ss95R8nGuHUWGfqw0J4eHLaw2BYOhaOhAnbURvMxfuNlkQJu3i+sM3IqnWyr?=
 =?us-ascii?Q?ReJfrOXiTL4O9zQF9uKdGcMuRXIR3w4h/64v4I9CmMiSS5rWmTxj7RMNz6Al?=
 =?us-ascii?Q?MqQb0hWJMTCuI50wxha6L4f1qkbinJ0jmFEThVmL9lxOXF90Pw3Koa9vxkda?=
 =?us-ascii?Q?pId6td14ktepIcSYSzCogh9gf4sWpNc9DgJUuboLng4FOED7wn+eV5ucNKnq?=
 =?us-ascii?Q?E2ZQFFHFgvv7xidwAcOi2O9Vb3K7bFIp0LWngch2/B/iO1Alay1msvdAyL4H?=
 =?us-ascii?Q?SvWLc1i3fdCQSniFN/vmL+oA3hi7uvg3RykYarlBRpwff7ycsViO/gSQvrQc?=
 =?us-ascii?Q?bYr9gu/Bvx0eO/y+VH9CDfmSg7ouQNMKJm6v6vsxdiosE+KRoxNP6+/sX7qV?=
 =?us-ascii?Q?msFanVinC0THrlGNdJgex7f2XhB7ilWuOI/UWYJTMVM/6K+GSHBiOSigjdtO?=
 =?us-ascii?Q?bA7OXrTrN+iMFS4ItcHiiWWmslSnJzzFrQxQxup0ynARJNQN/LCulyDYe7v3?=
 =?us-ascii?Q?FvLZBiZpiiXEYo52fpnhXdCoK8E8HsDgE3e/R3PFl0nnyEVU0I7K6NLMsFoX?=
 =?us-ascii?Q?PcTpy1ySRozC9IYRS+PAUgE0ESVY6NBBIi2Td75Ii43i+YyiF0qKVEFsEx6A?=
 =?us-ascii?Q?5wng2FepN/uCkGI8/SwNl6zuU1IMSA2KYiKMjNla2o+SxFvrbTtoGcKXDNRj?=
 =?us-ascii?Q?i+Vv5KKtDjTLmwM/TZw9Nfsfp+2E8uAKHvcwP5NmFp8DjXnEq1Oupf80KOm8?=
 =?us-ascii?Q?Nhg8T/sReSJgG+i+eZ/OmlcjdkkUHqJlhSVBpAb1WXP7Bcmv+4WnuFG8WMnf?=
 =?us-ascii?Q?svr4WAhPk6kdI6+ptLqWyjp9C/4s9+7d9xvjp84rBu38wet4aQ22tCiiGd9s?=
 =?us-ascii?Q?lxe0J9WkjRrxn4R5dVTOgi92hFaqbXJDDjolE2dBScJxNsHN/6DGTpXs/jmp?=
 =?us-ascii?Q?FfoEljI6/90SBIkXrmTSJxcHs+IuQl/gkYuNB2wS9DQEvohC/Oc3+qhy9LUk?=
 =?us-ascii?Q?qcbwtd0w3YZAysAzOi9+dhJx1fA9exT13DabgD8JFGjIc4Fto90TNAMzwiVF?=
 =?us-ascii?Q?Kf0C3YtZPPBxv40JvD8u8uW+CHb3ETDn3tddIKrFbHeh4lP8fWiKEKYhbw4?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e2170da5-52a7-4272-a27e-08dc8b4455f2
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2024 01:01:19.5717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6522

From: Easwar Hariharan <eahariha@linux.microsoft.com> Sent: Wednesday, June=
 12, 2024 9:10 AM

[snip]

> > +Operational Modes
> > +-----------------
> > +Hyper-V CoCo VMs can run in two modes. The mode is selected when the V=
M is
> > +created and cannot be changed during the life of the VM.
> > +
> > +* Fully-enlightened mode. In this mode, the guest operating system is
> > +  enlightened to understand and manage all aspects of running as a CoC=
o VM.
> > +
> > +* Paravisor mode. In this mode, a paravisor layer between the guest an=
d the
> > +  host provides some operations needed to run as a CoCo VM. The guest =
operating
> > +  system can have fewer CoCo enlightenments than is required in the
> > +  fully-enlightened case.
> > +
> > +Conceptually, fully-enlightened mode and paravisor mode may be treated=
 as
> > +points on a spectrum spanning the degree of guest enlightenment needed=
 to run
> > +as a CoCo VM. Fully-enlightened mode is one end of the spectrum. A ful=
l
> > +implementation of paravisor mode is the other end of the spectrum, whe=
re all
> > +aspects of running as a CoCo VM are handled by the paravisor, and a no=
rmal
> > +guest OS with no knowledge of memory encryption or other aspects of Co=
Co VMs
> > +can run successfully. However, the Hyper-V implementation of paravisor=
 mode
> > +does not go this far, and is somewhere in the middle of the spectrum. =
Some
> > +aspects of CoCo VMs are handled by the Hyper-V paravisor while the gue=
st OS
> > +must be enlightened for other aspects. Unfortunately, there is no
> > +standardized enumeration of feature/functions that might be provided i=
n the
> > +paravisor, and there is no standardized mechanism for a guest OS to qu=
ery the
> > +paravisor for the feature/functions it provides. The understanding of =
what
> > +the paravisor provides is hard-coded in the guest OS.
> > +
> > +Paravisor mode has similarities to the Coconut project, which aims to =
provide
> > +a limited paravisor to provide services to the guest such as a virtual=
 TPM.
>=20
> Would it be useful to add an external link to the Coconut project here?
> https://github.com/coconut-svsm/svsm
>=20

Yes, I'll add the link in a v2.

> > +However, the Hyper-V paravisor generally handles more aspects of CoCo =
VMs
> > +than is currently envisioned for Coconut, and so is further toward the=
 "no
> > +guest enlightenments required" end of the spectrum.
> > +
> > +In the CoCo VM threat model, the paravisor is in the guest security do=
main
> > +and must be trusted by the guest OS. By implication, the hypervisor/VM=
M must
> > +protect itself against a potentially malicious paravisor just like it
> > +protects against a potentially malicious guest.
>=20
> Tangential to this patch, can the guest provide its own paravisor since
> it needs to be trusted and apparently the only way to find out if a
> paravisor will be used is to rely on the (possibly) malicious
> hypervisor/VMM to provide a synthetic MSR?

Conceptually, yes, you want the guest to be able to provide its own
paravisor implementation, or at least to be able to audit the source code
of the default paravisor provided by Hyper-V/Azure. The paravisor is part
of the guest security domain, so the guest must trust the paravisor. It's
easy to envision that customers who are very security-conscious might
want to provide their own Linux and paravisor.

But that's all conceptual. I'm not in the loop any longer on what
Microsoft is currently offering, or planning to offer, along these lines as
product functionality available to customers. As you say, it's somewhat
tangential to the Linux kernel itself. But if someone who knows wants to
flesh out the big picture with a link to existing public documentation,
please do so!

And thanks for your review. :-)

Michael

>=20
> > +
> > +The hardware architectural approach to fully-enlightened vs. paravisor=
 mode
> > +varies depending on the underlying processor.
> > +
> > +* With AMD SEV-SNP processors, in fully-enlightened mode the guest OS =
runs in
> > +  VMPL 0 and has full control of the guest context. In paravisor mode,=
 the
> > +  guest OS runs in VMPL 2 and the paravisor runs in VMPL 0. The paravi=
sor
> > +  running in VMPL 0 has privileges that the guest OS in VMPL 2 does no=
t have.
> > +  Certain operations require the guest to invoke the paravisor. Furthe=
rmore, in
> > +  paravisor mode the guest OS operates in "virtual Top Of Memory" (vTO=
M) mode
> > +  as defined by the SEV-SNP architecture. This mode simplifies guest m=
anagement
> > +  of memory encryption when a paravisor is used.
> > +
> > +* With Intel TDX processor, in fully-enlightened mode the guest OS run=
s in an
> > +  L1 VM. In paravisor mode, TD partitioning is used. The paravisor run=
s in the
> > +  L1 VM, and the guest OS runs in a nested L2 VM.
> > +
> > +Hyper-V exposes a synthetic MSR to guests that describes the CoCo mode=
. This
> > +MSR indicates if the underlying processor uses AMD SEV-SNP or Intel TD=
X, and
> > +whether a paravisor is being used. It is straightforward to build a si=
ngle
> > +kernel image that can boot and run properly on either architecture, an=
d in
> > +either mode.
> > +

