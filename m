Return-Path: <linux-hyperv+bounces-7275-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCD3BF2B84
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Oct 2025 19:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C70E54F4CB5
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Oct 2025 17:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633C82561AE;
	Mon, 20 Oct 2025 17:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Ag0Jy02o"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazolkn19012062.outbound.protection.outlook.com [52.103.2.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA89A926;
	Mon, 20 Oct 2025 17:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760981449; cv=fail; b=oLM4335QcLNXeZYewRqHOh0VSdT1/gnBTZeN37uGFjevnZq0aCqKFCp9quY636+jccrn5sqKBvWlAL4rbo2vw6+6puT5kNVqVEDiMQp8B4syBjnMJTnUnH8JzZ/zg/yRX/1lOhCcsWbJWA8YusrFT02vdPk2RzKnwLQnFfYYVKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760981449; c=relaxed/simple;
	bh=lB27iU3RKNJZfO4c8Mcr5+pjQKX/ctSpC1MzG7Dt/NU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mY3gasZcKXiXdClg99+4Fd+76aGWWNSq4CDY2oQCDF1AITSJmN+TJWIexuox1FhZ9PSlpCaUKZKHj0aT2CZNvIDMej3UEPfkoWagEGhIVIlYdgZs9wKfWUphe4DFtHxpTlcMVv8y+sVxKnkPzdxCByBa7RowlTBftMCLVLAms54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Ag0Jy02o; arc=fail smtp.client-ip=52.103.2.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=reCQ9Y8sVY3Gq/S+thDsGl5tgLvNFEzMBjmQ1lF2NQV6aaIdj7uqHHVLDIzfBfpRCSBzeFWNFOfGv97OW5v216eVI+kQOGWaBlCc3iVMPb+lTI3T60KcJIDu83lsn/HY5YcPllNpAV7ywtUjop3uPZ++mCDmzKWl2MBs+5GZ1EXRHa3/LLkjbKhAjUqrcydzLcQs05IAhRNPJgQxTWBvCK/k0fgPSZmeW0pvmn79Is4wASg+826yaU06LdwueSCIm0rZkijOgXCVL6bqTY7qsueo3iel5nalr6Nwd/OMBQs/Sh8BF/IYJlb/aW31fJugQkP7n1oj7z3GBbSSYLvKXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lkiCMk0rMO5RATPChqL5M5GRNDKDlL7IwwtTgpqhRTw=;
 b=LXUEuWtG13Is33h97inkl+neRex9HKONKPXMxEedIf1baNYQaAzNZ6Os7hxjQV0RX0EoD2lwuvZWY0DFPRqEfGdUGDhgFN3Xr88xyfs6opfwtYJ4EsOB8hC2eUlcKBN/P3+4T23RbyBD8ISolT98NZhstDg6DLxxW32/M7GI++zpc1qrKrPeiV5MwglmmmKGwUqYzhe1Z3h1897xul5ibvsW9C8I+YsCOhcw2pMW6nH3r3w7Ksse3iXqt+qBe/cbafJAnK5okjmlQYcPmX2h+K2OGJqvd7xQIRc9jbY2ungeLhaKfcjGn5f0Dw0w7xyqf+0w8WP4jTgsiWUQVq1JWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lkiCMk0rMO5RATPChqL5M5GRNDKDlL7IwwtTgpqhRTw=;
 b=Ag0Jy02oNksArpsaovTuBfVOLx4ycayfrVDMqwyTUvCU4eRejb5+LaXMiWLDbsAIcoZfyupllLKwNEmpNJrfixCmkGiAYiJpSI+GGs6y7Pa/0dO+eMij30N67rPsRmEpYXiLMGu1ZaIB5X4VPFZRofJq+lNCvkh9VHUeTS/7XZB8YC/R1oB1fu3ReySTCR5NDvMx5Rtmv8/0bbb311WHEinD30OWsr/9uKOjRwA3TARZyiN4Tb9Sy9bD5zkX1dlUcObjWUk5EiMkAPu3b8PVJ8h1Hw4XOTS1RDsB/d1RAJvexkllyypT/LgTTbk3DAJhe5DlghWIUBnOj7AUDLYZSQ==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by BL3PR02MB8297.namprd02.prod.outlook.com (2603:10b6:208:344::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Mon, 20 Oct
 2025 17:30:44 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::6007:d1a1:bcf9:58ef]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::6007:d1a1:bcf9:58ef%4]) with mapi id 15.20.9228.014; Mon, 20 Oct 2025
 17:30:44 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Praveen Paladugu <prapal@linux.microsoft.com>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"arnd@arndb.de" <arnd@arndb.de>, "anbelski@linux.microsoft.com"
	<anbelski@linux.microsoft.com>, "easwar.hariharan@linux.microsoft.com"
	<easwar.hariharan@linux.microsoft.com>, "nunodasneves@linux.microsoft.com"
	<nunodasneves@linux.microsoft.com>, "skinsburskii@linux.microsoft.com"
	<skinsburskii@linux.microsoft.com>
Subject: RE: [PATCH v2 2/2] hyperv: Enable clean shutdown for root partition
 with MSHV
Thread-Topic: [PATCH v2 2/2] hyperv: Enable clean shutdown for root partition
 with MSHV
Thread-Index: AQHcPSm8o+gOyOR+00uJ8u6QFjaVJbTFIVIggAYZboCAABbHkA==
Date: Mon, 20 Oct 2025 17:30:44 +0000
Message-ID:
 <BN7PR02MB41485DB7E9B53B4CEDA596EAD4F5A@BN7PR02MB4148.namprd02.prod.outlook.com>
References: <20251014164150.6935-1-prapal@linux.microsoft.com>
 <20251014164150.6935-3-prapal@linux.microsoft.com>
 <SN6PR02MB4157FBBE5B77C65B024D3589D4E9A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20251020155939.GA17482@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To:
 <20251020155939.GA17482@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|BL3PR02MB8297:EE_
x-ms-office365-filtering-correlation-id: cb94439a-efcf-49c0-e17e-08de0ffe6653
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|19110799012|31061999003|8060799015|41001999006|13091999003|15080799012|8062599012|3412199025|440099028|51005399003|40105399003|12091999003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?/qNvLmiER44y/d5oCzYjqiHQ7DSMDGzusrvdqRsfb3iQZJOoADThK5tRjsrM?=
 =?us-ascii?Q?bWNxzOPWTxHtA7eLt8jE+zBzpfIon3DYPq1ZtNixHrFQywhDkQsY6HlCYO0+?=
 =?us-ascii?Q?9mIJ1FOy7lP1fFYotNd/6kfdWbyVlqiVCXcr/DGN9uvJTWpc5w9gHWl9VcYW?=
 =?us-ascii?Q?7B6wIdCxvClnJU3zb5bUH76IVmj9GVM6oKuDj1AgNhM6qKC4jVjJ0yBqr8w3?=
 =?us-ascii?Q?kdkJnCqOXtebImv1e+Kssnj90i1U1irDaIj721cS4slvz1/6Xf94mVeyNS5l?=
 =?us-ascii?Q?dhUoEdKVkTUpS0GF8tFTmJs6TCRCt8t/927xHsJ8LMLseFenS3bZdYGW0E5U?=
 =?us-ascii?Q?IFWwSlS10lFJts+8y6PzuzDUHN5w3ZAfooBGfDo/sylBE1t0GPHO7CGwfjHx?=
 =?us-ascii?Q?wZYCws58ei6UeOZK4Fb6KaNmPMyEv5pxmtEBG7fOBxvgySA2dPs71ORn5RsH?=
 =?us-ascii?Q?upUqWSNJAR/xDsmOV8z7gPFD8XpURRnj/V0vUIQtCKi4B61i7P1ybPbLmBa7?=
 =?us-ascii?Q?ndJ0NrlJEG3a6F2sSBc2ppVRjUveZFV4Xcrd4aEK1giGxv6CAK4HDodfZOez?=
 =?us-ascii?Q?fIEJf770pYWnZDgnJrQddZu0xQS8gPFpEWdtWofEu8ZG3rL31ACfWWscnWFm?=
 =?us-ascii?Q?++d3g0RKLIjXHr2ky56QQ3WxlqjC4iX2kSSwV6+noe/waj2ErjVWZ9IDQ+N5?=
 =?us-ascii?Q?P92G0ZuIfbEmVLEAWpg6y8RNq4q7o7mUDm1JlWuPTkKP3Bo3xKaBrynJwmTZ?=
 =?us-ascii?Q?kF4wxGXcI+gyy6YpVifi9JB82l//CX9VNV5u84Rq0NZiGOVI5Xld5lmgVLx6?=
 =?us-ascii?Q?EAcB0m9a8kOBQ1ywCvxWcI6dctfg2wXCmT26lSqCVT4e6N9o8uV/u7kTIfAA?=
 =?us-ascii?Q?UTh1H1k5dhAgjgqahrTQSEV3tpMfV+vwSUL/j9QlwTDNYSqL0Z5/JsIktHgn?=
 =?us-ascii?Q?09AojchiHtv476f0Fz+3UlvwY8JNfd1pfvSoZJf1HNjHj3WVMvnseF1jyNmI?=
 =?us-ascii?Q?Qv9iyYrK8DJPVVFLYxr3q1+dUxtMMQBGTEVa9RUO2C80F3erlwcbrpEKYyQZ?=
 =?us-ascii?Q?TDPPO5xEXRtyBduK+WVon5/tcD1/aYKiE+mBqa2iaBYBaOGQ4b7E/I8bY9zp?=
 =?us-ascii?Q?48sidS8wMA6yS8Oe+pw+BJHX/3u9dDx5j80qnAovQhZXz/xbG5IPBIgDqv4h?=
 =?us-ascii?Q?jUqkfRFTUhWuCsGKWzSPajrrv0RU0axLQ8np/lmGcrCpZd2Ab2QVd979vtmK?=
 =?us-ascii?Q?d1lQ3Y5Ut5Stt6CKWSvFbbWYyAk7pGcVjtE3FRQtYw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?IRulloQnoiJEOGZ62HPL6k4mvF6CS3v8EsE8mMi8K+2wf4qfUVDj5TNOKKDL?=
 =?us-ascii?Q?Be84oCg8IxKF1qeSvY+OYoFhewO+pzrh1jmL3pKIEuX9/g1tSOR1eeDuZygD?=
 =?us-ascii?Q?e64ubsH/IbqwujYUrP3DS+8pdM3K/FSddKVqCrBTwpOKfCmS7DhBDpa4uzq1?=
 =?us-ascii?Q?Tvzhmb92Zo50UyUfTitCTgfS6JDU+nTV5gPqzprsQVrzNyB7bVn50fvdZAPY?=
 =?us-ascii?Q?/cjqgzow3tuQAkxMZw3oEq/KfmIoD/4Kk+QFeRaAjOrKkPnDpalVWp/82Pkp?=
 =?us-ascii?Q?O+8gN+moEEOarWBMM1iHffT2gGTX9wd6LLV+9806cDGTXUIwS6zRGYI+5Km9?=
 =?us-ascii?Q?wjd5GwWepA2PBLGDR6RqGXARbcLYmLorpzMVPNuSmZUDhIZM4uqQTjNU4VkC?=
 =?us-ascii?Q?2ZzVJ0lRwS6ew8iCmF6UjthxgIe6unoQV7QRYl6fWYRg6y1DwIwMXpWZ31mm?=
 =?us-ascii?Q?PqSA01/q3zWhbSq3bJCTFmR9vYU4NIVgF2KgzhnIF2coeHpxoXu0HwAZMYYO?=
 =?us-ascii?Q?rQftRvpWLbAGbU6lW8HKh1ins2c6PWUJHJhTwekuUFcbZ8hGUufXRXhgA4XH?=
 =?us-ascii?Q?FoeSm8aCeaawsQInyr8cGl2kwqv1vfX/5/gsAx0zh65CocIrffj5ffsZkNg/?=
 =?us-ascii?Q?f5EFZtsGK3eSKi5aq8I8KMIOBlIpj3RdMWTOhAm3uMpa/7g5uKj80kDFIMOX?=
 =?us-ascii?Q?I69BaqGYLhfVax4KusCnl9mUCBQWrH8Od5eKmsxrWCxgtuIh6nyRw5TbqIaZ?=
 =?us-ascii?Q?r6KJ9maP2z0COY8+DivpfuNBi9rLpeLNU6GUsehfeG8JsF/VmMgD06of+Pzt?=
 =?us-ascii?Q?bUgZQPoY14Ze4CNWKxcRtywI5L5C7xMau6+7Vm6T9tSoAjeNxSxFlaQOPwO9?=
 =?us-ascii?Q?IQ+GaGmmy17G593T7df9Df+d55Mgq9iBoMG5P2tjF4obn+Sly5H2y2YPet/m?=
 =?us-ascii?Q?IkBlIBCUzvuMttueRNZNJCNofX7ZW8DyUMyTAWWzlr7smv7PvAoZfxhM8ZZo?=
 =?us-ascii?Q?ynl6eVE3ZgKxDxIOVm8Ojoq74RmOxeLerY9Gf3xEmUA7gcDAgMyyaoeMASRy?=
 =?us-ascii?Q?cdNbcJGK73TvvPQy/nhUEqYIReIh8YAlHM7/b3kLYStld4icGSEgHLU0c6O+?=
 =?us-ascii?Q?7Rv3a+YUqsXjR2qlAYZjjBe8ixtehlczvG5W+cXgIbb0NSrq+zSVascAZowG?=
 =?us-ascii?Q?6y3mHVZ3j3yIqwIoI/Om9N9giNJMHaJWLhZI1TExK5k76zxKidcGtN+zz2k?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cb94439a-efcf-49c0-e17e-08de0ffe6653
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2025 17:30:44.5223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8297

From: Praveen Paladugu <prapal@linux.microsoft.com> Sent: Monday, October 2=
0, 2025 9:00 AM
>=20
> On Thu, Oct 16, 2025 at 07:29:06PM +0000, Michael Kelley wrote:
> > From: Praveen K Paladugu <prapal@linux.microsoft.com> Sent: Tuesday, Oc=
tober 14, 2025 9:41 AM
> > >

[snip]

> > > +static int hv_call_enter_sleep_state(u32 sleep_state)
> > > +{
> > > +	u64 status;
> > > +	int ret;
> > > +	unsigned long flags;
> > > +	struct hv_input_enter_sleep_state *in;
> > > +
> > > +	ret =3D hv_initialize_sleep_states();
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	local_irq_save(flags);
> > > +	in =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> > > +	in->sleep_state =3D sleep_state;
> > > +
> > > +	status =3D hv_do_hypercall(HVCALL_ENTER_SLEEP_STATE, in, NULL);
> >
> > If this hypercall succeeds, does the root partition (which is the calle=
r) go
> > to sleep in S5, such that the hypercall never returns? If that's not th=
e case,
> > what is the behavior of this hypercall?
> >
> This hypercall returns to the kernel when the CPU wakes up the next
> time.

I must be missing something about the big picture, because "returns to
the kernel when the CPU wakes up" doesn't fit my mental model of what's
going on. I thought this function would be called, and the hypercall made,
when Linux in the root partition is shutting down. So if a CPU makes this
hypercall and goes to sleep, what wakes it up? And when it wakes up, is it
still running the same Linux instance that was shutting down, or has it
rebooted into new Linux instance? In the latter case, returning from
the hypercall doesn't make sense.

Can you explain further how this all works?

Michael

>=20
> > > +	local_irq_restore(flags);
> > > +
> > > +	if (!hv_result_success(status)) {
> > > +		hv_status_err(status, "\n");
> > > +		return hv_result_to_errno(status);
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int hv_reboot_notifier_handler(struct notifier_block *this,
> > > +				      unsigned long code, void *another)
> > > +{
> > > +	int ret =3D 0;
> > > +
> > > +	if (code =3D=3D SYS_HALT || code =3D=3D SYS_POWER_OFF)
> > > +		ret =3D hv_call_enter_sleep_state(HV_SLEEP_STATE_S5);
> >
> > If hv_call_enter_sleep_state() never returns, here's an issue. There ma=
y be
> > multiple entries on the reboot notifier chain. For example,
> > mshv_root_partition_init() puts an entry on the reboot notifier chain. =
At
> > reboot time, the entries are executed in some order, with the expectati=
on
> > that all entries will be executed prior to the reboot actually happenin=
g. But
> > if this hypercall never returns, some entries may never be executed.
> >
> > Notifier chains support a notion of priority to control the order in
> > which they are executed, but that priority isn't set in hv_reboot_notif=
ier
> > below, or in mshv_reboot_nb. And most other reboot notifiers throughout
> > Linux appear to not set it. So the ordering is unspecified, and having
> > this notifier never return may be problematic.
> >
> Thanks for the detailed explanation Michael!
>=20
> As I mentioned above, this hypercall returns to the kernel, so the rest
> of the entries in the notifier chain should continue to execute.
>=20
> > > +
> > > +	return ret ? NOTIFY_DONE : NOTIFY_OK;
> > > +}
> > > +
> > > +static struct notifier_block hv_reboot_notifier =3D {
> > > +	.notifier_call  =3D hv_reboot_notifier_handler,
> > > +};
> > > +
> > > +static int hv_acpi_sleep_handler(u8 sleep_state, u32 pm1a_cnt, u32 p=
m1b_cnt)
> > > +{
> > > +	int ret =3D 0;
> > > +
> > > +	if (sleep_state =3D=3D ACPI_STATE_S5)
> > > +		ret =3D hv_call_enter_sleep_state(HV_SLEEP_STATE_S5);
> > > +
> > > +	return ret =3D=3D 0 ? 1 : -1;
> > > +}
> > > +
> > > +static int hv_acpi_extended_sleep_handler(u8 sleep_state, u32 val_a,=
 u32 val_b)
> > > +{
> > > +	return hv_acpi_sleep_handler(sleep_state, val_a, val_b);
> > > +}
> >
> > Is this function needed? The function signature is identical to hv_acpi=
_sleep_handler().
> > So it seems like acpi_os_set_prepare_extended_sleep() could just use
> > hv_acpi_sleep_handler() directly.
> >
> Upon further investigation, I discovered that extended sleep is only
> supported on platforms with ACPI_REDUCED_HARDWARE.
>=20
> As these patches are targetted at X86, above does not really apply. I
> will drop this handler in next version.
>=20
> > > +
> > > +int hv_sleep_notifiers_register(void)
> > > +{
> > > +	int ret;
> > > +
> > > +	acpi_os_set_prepare_sleep(&hv_acpi_sleep_handler);
> > > +	acpi_os_set_prepare_extended_sleep(&hv_acpi_extended_sleep_handler)=
;
> >
> > I'm not clear on why these handlers are set. If the hv_reboot_notifier =
is
> > called, are these ACPI handlers ever called? Or are these to catch any =
cases
> > where the hv_reboot_notifier is somehow bypassed? Or maybe I'm just
> > not understanding something .... :-)
> >
>=20
> I am trying to trace these calls. I will keep you posted with my
> findings.
>=20
> > > +
> > > +	ret =3D register_reboot_notifier(&hv_reboot_notifier);
> > > +	if (ret)
> > > +		pr_err("%s: cannot register reboot notifier %d\n",
> > > +			__func__, ret);
> > > +
> > > +	return ret;
> > > +}
> > > +#endif
> >
> > I'm wondering if all this code belongs in hv_common.c, since it is only=
 needed
> > for Linux in the root partition. Couldn't it go in mshv_common.c? It wo=
uld still
> > be built-in code (i.e., not in a loadable module), but only if CONFIG_M=
SHV_ROOT
> > is set.
> >
>=20
> This sounds reasonable. I will discuss this internally and get back you.
>=20
> > Michael
> >
> > > --
> > > 2.51.0
> > >

