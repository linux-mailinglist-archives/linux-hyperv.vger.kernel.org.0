Return-Path: <linux-hyperv+bounces-4034-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9595BA42D45
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Feb 2025 21:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB1B07AB1C9
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Feb 2025 19:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C547320765F;
	Mon, 24 Feb 2025 19:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="YFg7pcga"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azolkn19010003.outbound.protection.outlook.com [52.103.12.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29D02066F2;
	Mon, 24 Feb 2025 19:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740427174; cv=fail; b=IcJZtp7mTgudOE+jb4asD+IHeiocIGCY+6oJfDbmlJ4uzpDdpMhmM2swf+6Nl2sZ1rM19hOiinImC7ibmFOvw/K9/YErYIAqkAiDDPWd+u6YYuB337yGjOACF4CfUyOw6AJ5KTPqhruHkmJg8DXpPkRTyFPuUdAnP9XHBsCKeSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740427174; c=relaxed/simple;
	bh=a0AIZU5LDB1zfw5fpADuTuxGtHKiaQO3li49WHHLsQA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oHzXNHGQG2+AqI/m+12seu98ccMDRfT5OMB3BD9YSXhYkFrZfHzlVhn23NrphQS/fVytTJYwkCCddO+UY7bmvD1WjY+IOwp5+QjseDvGiETvEXRZmA9Z+dMCSjXowzu1RPiPuI8q6IrbDbQ8ZcmfoS1x/suQxH/Fytd/OEbWCuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=YFg7pcga; arc=fail smtp.client-ip=52.103.12.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GUqzhhm2dUO/0Cl8M7dSP0WfFQrpmQS9gFYOpnIr5IEBUDz3fsEEanQx/5MF6suNMQqIOqWxDkV3AVu6yAk42u0JpkPfzNDWx4v4hnNErfGDYGEiI1A+HsAIo/rlCSukPf8WV5n7bt1gTXVaW/7+MzNx1+rnDlzNRNDtm2WXb3aK2SSMGif6O4kQpxpPXUFACz8i4/b1G5BjL6/rJbUcSGp9Dghg/cRR2Tr+rCLYePrDxoSP2ePvWge9700doo8+xulqwCJBkYSUhadH97AxKxC04rUONBoLPLK/bALI5c7GbDD7GXQnbmYgEOyKTPdxmqclGzGcNgqV9kLyDgEN9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0AIZU5LDB1zfw5fpADuTuxGtHKiaQO3li49WHHLsQA=;
 b=muICIFTNBBkSmpYSQVncahc633LAnSSGOvGw880xF3BnexdKTc3PWVKLEPIgX+mP+4IZUEZ3y5VzM72RES4Kxl8eyQ+cdEQRHClLXqzly5UQ0kODwvFtEhA9WTI5SCqAihcSgmPZvCE3bkmmsN3Ia7iRoRLbJfDFVPbmh8oD3XBzUOSI/Pli00Fo8q54SaNxRRQd4s+xVgiVCTeyAHBGf2cPoz9riKzae1griwqsLXsXz25YW2Gpjzy57Bm0iv9zYBYbOzBzvwfyZ+SyAWyMLjYLcaPQJzYQPzckl/pq0rH5+J5Wvt/Spc8KKgo0F0rkyN+ldY/0DFJtfWa8n3LE+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0AIZU5LDB1zfw5fpADuTuxGtHKiaQO3li49WHHLsQA=;
 b=YFg7pcgaQTfAidjWcm+JUk534b55rmo5I/ICbrb4c3Ki0X/ynpiLiRfQQwaao49Q9Jel2X7vWCTrsUES0LhPfJgGHux13VBb2ekL/iqLG4BJai2zmJiB++663pPXgqhaeGXVcELMDugKwuzO8rvDnAZgfkP9IYTTxYRv/bW9J+0YVnTRcB/UQkzgzDDD2dk9wMoZtViYEJzSJyuQ8EhJAY/PXVE1IKGCn53ragJZYSIQhoiKtgHro0uLl1C1QmgACNKTsPJBCLXT6aEMI7kjZBtE4TIpSZi8qj5Y+0uzbQAJVvWvjXdtcGdhtPOCUXdZtbTko+nrIrYrLn3ZLV6KqQ==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by BY5PR02MB6866.namprd02.prod.outlook.com (2603:10b6:a03:237::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Mon, 24 Feb
 2025 19:59:28 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911%4]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 19:59:28 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dexuan Cui
	<decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, Haiyang Zhang
	<haiyangz@microsoft.com>, Petr Mladek <pmladek@suse.com>, Andrew Morton
	<akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	John Ogness <john.ogness@linutronix.de>, Jani Nikula <jani.nikula@intel.com>,
	Baoquan He <bhe@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ryo
 Takakura <takakura@valinux.co.jp>
Subject: RE: [PATCH v2] panic: call panic handlers before
 panic_other_cpus_shutdown()
Thread-Topic: [PATCH v2] panic: call panic handlers before
 panic_other_cpus_shutdown()
Thread-Index: AQHbhKgE7m7J+NObG0GGYUSr+UK83LNSW/uggAQxDICAAFKgsA==
Date: Mon, 24 Feb 2025 19:59:28 +0000
Message-ID:
 <BN7PR02MB41481BB6067A7265A459AF69D4C02@BN7PR02MB4148.namprd02.prod.outlook.com>
References: <20250221213055.133849-1-hamzamahfooz@linux.microsoft.com>
 <SN6PR02MB4157D993CCE04F2D46E2B8A1D4C72@SN6PR02MB4157.namprd02.prod.outlook.com>
 <Z7yGv_ZyeyUueXLz@hm-sls2>
In-Reply-To: <Z7yGv_ZyeyUueXLz@hm-sls2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|BY5PR02MB6866:EE_
x-ms-office365-filtering-correlation-id: 43d56d4e-36c1-4024-22ea-08dd550dbf09
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|8060799006|19110799003|8062599003|461199028|102099032|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?UjBkumd6d7qRi08WhcE3o5/AD2ewsQ9mVEn3V2PLrQvqq+OlHul/hbDcHcyS?=
 =?us-ascii?Q?yCLyPvuDr+v67AtjHwRWCUQYsGxl2xs/ify677HpMjQoeebPeI7wM9+UY1lt?=
 =?us-ascii?Q?MfGbyxjV9I6anpfYxmIm1ASch7phuyhIA30z7bKB0vyemNrjt9Ud8ikZUGHG?=
 =?us-ascii?Q?DgFB9Or3n6D7C2kfxnyiVUWhROOCD5sEh/GJKSBKKVtKxlIPWZkeP84nyCm7?=
 =?us-ascii?Q?W8xgNz9cSci1eP77799OWpyO5KNP8Ssyvn9zbdijOH61h4EVCGUIf+SGK7uI?=
 =?us-ascii?Q?oH1YD5b2DWRgfj1rqB0cmoW2/xVNfFXZpl1Omao/cHoXKJzReE5N3f5IGfBU?=
 =?us-ascii?Q?f7v7/JsonVyGoq5iKfofl0IvEZACP4TY/2xnHHRRNAi10OchyHnvzjIHPTbq?=
 =?us-ascii?Q?xwfMZ5qzSQ7VhS7ifD0O4g+LDdHwSroZK1A84WxDRkHKfMQOv51LXoupMpL8?=
 =?us-ascii?Q?J3xn5Rp9118bV3x0Y8buh+6r2ICPZEsz/taw1mH+L5FfedCgil28VIDw5nA/?=
 =?us-ascii?Q?kOWMJgDa1md+WO0Fy2PSYJ7/KUgWOZGHmL6WqElBp0cHKuEl/QM1xtKG9l4T?=
 =?us-ascii?Q?4DL9p9H3c5CF1HO7fBlj03avdAwDbSKeySjr4i3G5CkeesWBUbFKpLnqeq0W?=
 =?us-ascii?Q?LG9c76ZJYeFbp0muG6ZgNfonM4zgNUQKrW4Yu9XRnAeJyK6hyUWFf5hXvLJe?=
 =?us-ascii?Q?EBvFzlZyx5tFnycYjOKWpuUciAIkJBhlSPgIYOgp6XV3ch7u3+N+11dT4NtS?=
 =?us-ascii?Q?rrcGcZK4OrqPVoZLcXxxpcoWs3kk0/QpGImmaCuk4qnQGX1dgDvaiz3d4eBX?=
 =?us-ascii?Q?K27YmWX+X7Vesi/2pw0l/KpYdTPR7BJ34JpXNYPH3+QRdnxtccJH5HY7Qcpp?=
 =?us-ascii?Q?+xJX+apD5JDJsdAMJ7PVt/QPyYqlVb2uz6blLt5BNNwcRztIk1XaKRv3PAko?=
 =?us-ascii?Q?pOdGdh0KoIUSKvo1hEdmZOqjezYIlNvD85ymys1d8cDXHV/ZNZwRPBwc1R5B?=
 =?us-ascii?Q?tEEH5ecjLut1RSQMLkwD8QTYL+f0CFPqR6lM8fojykVcKNI=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?JCKLzW35WKIiGpKzFZTTdQPGtDNfhFeFGNrfOZfFdgdqrPOl3VBWcxEg9O+q?=
 =?us-ascii?Q?xwBSbAdR6DGwx+5x+3OQqGZMrgqdWft3I8whNv/YAZlNviz0gC5Rf6Yiday2?=
 =?us-ascii?Q?+8YWXVeDAIzi7Xif9XVLiYTseBbw30HwmtLyhcwm/wIKJy8QmupJBURy920N?=
 =?us-ascii?Q?lydQvLrLJwx4nEC3WgarzYYOKQbVEJWdwCxK2MrlwDeTtyaKLprx790oUg3J?=
 =?us-ascii?Q?IqAkYxkgA0Tu5glt6FG0UgATnwYbxfdQNU38SmfKInzmLJ22tVvacmBqnKww?=
 =?us-ascii?Q?bR/pi77irZ3JdIwVAgxmFY78j5tvAMSVfbE/wi/6BB21Jvgg2pXIoxpz2EIi?=
 =?us-ascii?Q?Iji3iwTXMKObtXWxdqR2SF8sSDVT9fYITInonD1qyTQR4VcB3pSaGK3MJ13F?=
 =?us-ascii?Q?Ghw6mzuj5ImNumGZVjFl9NJrZFWvRmCOMSMhJJ6s8cLqsp26SvDickgVNZ11?=
 =?us-ascii?Q?AQj/5gQsPXkqmcEdhoU34lLCrKELho+6NHt3Na6C52vHYiNrbInJdsCZF21p?=
 =?us-ascii?Q?EtZdyWi4gIBbDkf2qR2dadD7iExycIyMo93DCR20zkfxLx3o6FAgCvY0OPuT?=
 =?us-ascii?Q?4t8xkB8pbrCrQuF9gMu9q6URDGjjtw8VSaqQaYsOIvEMkoucezpJVn8gOfpo?=
 =?us-ascii?Q?LIMopkCEnhhlz4IuJUVhfyc+/G/UpW6lP0UlgU46QBt5+pn8Tl23TEF7SIup?=
 =?us-ascii?Q?yYk6q1od1Rx810qNq+4uRkiP3qOj1qBXSzYsB4zdPgCGelgxNt/9fGi1oTS8?=
 =?us-ascii?Q?0TFxUf0B8Ka0zHaDigTcyRtBAFUxz7Asht1TWJIQbZJhtxB7BZRkpoXx7j1i?=
 =?us-ascii?Q?BNs6Q4I6hzQGcTvZtBqHvCOYdVbWMTCoRC7DhSLGTE2ZS3Nn+pBBAvVZ+aJm?=
 =?us-ascii?Q?4WGlDv9rSXnZnULeIo/8GTtCyKhP1/NSf6xZVDMidRA99kilRmOAUt9YGUXN?=
 =?us-ascii?Q?zcB3Ze636TsntgTWb4i+vxpw+AJb0bVhzb08vHYYfX4oA1YcStIs1f2o/FL6?=
 =?us-ascii?Q?XL4Ad7y7/WdQyo3yoqBb2pLhVRY1FSn5cGczQV68DUDyAjBUbllW1/f4GYJy?=
 =?us-ascii?Q?NR63C/fqz6O7WpPqhP3aWZgo40+yRQ2dDx0vmYfm3rgV1HiETc/gaslBoy2R?=
 =?us-ascii?Q?yEVJsxwO9fnw2WZBWEiUVKJ0ErvQEAZfTucAbJXkTVQjZ+M9sxA2L9SjfI5a?=
 =?us-ascii?Q?frKyV0PRS6wbjNCA0s9SrFuKleJFsVkrn6o0OCB0H5mvkvh1M8ZQjMDKF20?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 43d56d4e-36c1-4024-22ea-08dd550dbf09
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 19:59:28.4364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6866

From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com> Sent: Monday, Februa=
ry 24, 2025 6:49 AM
>=20
> On Fri, Feb 21, 2025 at 11:01:09PM +0000, Michael Kelley wrote:
> > From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com> Sent: Friday, Fe=
bruary
> 21, 2025 1:31 PM
> > >
> > > Since, the panic handlers may require certain cpus to be online to pa=
nic
> > > gracefully, we should call them before turning off SMP. Without this
> > > re-ordering, on Hyper-V hv_panic_vmbus_unload() times out, because th=
e
> > > vmbus channel is bound to VMBUS_CONNECT_CPU and unless the crashing c=
pu
> > > is the same as VMBUS_CONNECT_CPU, VMBUS_CONNECT_CPU will be offlined =
by
> > > crash_smp_send_stop() before the vmbus channel can be deconstructed.
> >
> > Hamza -- what specifically is the problem with the way vmbus_wait_for_u=
nload()
> > works today? That code is aware of the problem that the unload response=
 comes
> > only on the VMBUS_CONNECT_CPU, and that cpu may not be able to handle
> > the interrupt. So the code polls the message page of each CPU to try to=
 get the
> > unload response message. Is there a scenario where that approach isn't =
working?
> >
>=20
> It doesn't work on arm64 (if the crashing cpu isn't VMBUS_CONNECT_CPU), i=
t
> always ends up at "VMBus UNLOAD did not complete" without fail. It seems
> like arm64's crash_smp_send_stop() is more aggressive than x86's.

FWIW, I tested on a D16plds_v6 arm64 VM in Azure, running Ubuntu 20.04 with
a linux-next20252021 kernel. I caused a panic using "echo c >/proc/sysrq-tr=
igger"
using "taskset" to make sure the panic is triggered on a CPU other than CPU=
 0.
I didn't see any problem. The panic code path completely quickly, and there=
 were
no messages from vmbus_wait_for_unload(), including none of the periodic
"Waiting for unload" messages . I tried initiating the panic on several dif=
ferent
CPUs (4, 7, and 15) with the same result. I tested with kdump disabled and =
with
kdump enabled, both with no problems.

So I think the current vmbus_wait_for_unload() code works on arm64, as leas=
t
in some ordinary scenarios. Any key differences in the configuration or tes=
t
environment when you see the "did not complete" message?

Michael

