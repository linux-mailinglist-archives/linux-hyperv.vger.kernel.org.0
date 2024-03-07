Return-Path: <linux-hyperv+bounces-1676-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AF68754E8
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Mar 2024 18:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC3A728504C
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Mar 2024 17:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711EF130AC4;
	Thu,  7 Mar 2024 17:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="O18NOmG3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02olkn2024.outbound.protection.outlook.com [40.92.43.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D7412FB0D;
	Thu,  7 Mar 2024 17:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.43.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709831507; cv=fail; b=X+7BMhPJeqnoOqLNcFSCrMUzQhoo+77F1HqiNlgzYVmx/c6Aq1zHMwOg29OOTiIWpaMRS3NzzqZSdBbk8pxRVnvkCiSN4raN8aXjVFPMom96wmD2jIUgkcVyo/tdtbCeyYqiGwRdkqkpTkTIRswr8R0HTYA7+PeJgi5SbLN6YVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709831507; c=relaxed/simple;
	bh=Ug5BaFYwQpY5dJpOzzj6zgR5yhv9vGCwAPBoiiCJOJo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JX9Uh2u43yRCgFum5TdIM9f2FVSoK4sgXeYMP3W6lQOgyeK9mzmvjmwGVVvHTdYue9fdHWYGJWEieCFFZJwCqQSm+CPGmaAII4dRFqsM6J8o24RxCakKpbwCX0T0q83yo+z4w3OtaPQ5KA4OyONQeHLQxpJKLVFWIsDAFh/c+Zk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=O18NOmG3; arc=fail smtp.client-ip=40.92.43.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GrnxwZ4jSkA79IptxOrL+0MZbK7tyynvco/nw6e6QxuD/YvMFjblNw19wEaRdTj8tNgwrnbAeuCV+7v9WCiLI+dYvnTOPt2Cs+l7jeA8hxYl9k1qV8qI5kcrRY/fvBTggQHSei/tE5HVo9iR8gCxMNdRaK31hjcoE+gYlx80Op8jKjU3RFi+mHJRpqIrR+YQkNWxRQmAU6a/qCx3ENhBfIG04BYvM+RKdXULhkqwi5NNlbJJ4Bdp3tj3SFykJXk/9KjSmnwba0rRLNCd4Q+c1lHk5Vz6sm+PxaiWqGhJFVgEICWsw8+9OP2ZDyYVXArldsCFgAGNITX9W/rBumegSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jyEw3+TZ8Cb/DL7MMUUI+H4SQ8Mo3kN2cAfnrECi7UA=;
 b=M93Cx3ei5FgXxiJ6wWYO0VHxUkn66uzDVU6Ec0T4DDJleCUuV3ndfMoDSqRSiw1VDNPXNh6mMlp6TEdNfJYQU+hKOfYp3cRyrTy8vWxsL9nQW9muYm66//o6iDuGIcK16xKH0KtsZkCwORkd2oVAHBMk7Vzi+qfLdDc6waFwpHeprMJ5V8torJK88reT0QfmX3gRFoOdc98S3U0IcDHd/T4T7V5HL5RJNJnToxnH47h+2QfXED17C39DCqz4xat/Xgz5dztJAuQssJo1djI0TffItvKJRN7tlXb5nqOR7snokbyKpRkt9en4QqUEK+HAqmntfSctdwkr5zPThfJm7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jyEw3+TZ8Cb/DL7MMUUI+H4SQ8Mo3kN2cAfnrECi7UA=;
 b=O18NOmG3Zk99dIPDSr+o/BfbLKvbqs4sDPegexGM68bCZttKD3re+E4yWp/Pkp4ROE80iIWcT8DeXEkbv2P4HZ26IrEb2HynAF4ZmcEps8OrVjk/JUMztL/mvMiZRMBkQZlCwJt3tVBrhlpNati3or7vVJrpjBz4RfqEBGDqKUtKAVxOwI7+1wb9bxyyNdYonSN2UOjfpT6GIooXG/SdeWJt4EasJ4Tr4Z9ZL5iPgRhT+3iUMspcKQg/CFo0sQoM15sRfCPG36PKLbphxGk4WZEwBhLEd68GBGsryJ1xvnJu7rH6ejggQoqhLw3e9TFdTUUnslWiaYfrS9C904uP7g==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by LV3PR02MB10150.namprd02.prod.outlook.com (2603:10b6:408:197::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Thu, 7 Mar
 2024 17:11:42 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 17:11:42 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "elena.reshetova@intel.com"
	<elena.reshetova@intel.com>
Subject: RE: [RFC RFT PATCH 0/4] Handle  set_memory_XXcrypted() errors in
 hyperv
Thread-Topic: [RFC RFT PATCH 0/4] Handle  set_memory_XXcrypted() errors in
 hyperv
Thread-Index: AQHaZTRXjdPXYbhP4karQ0dDTiSBNbEjNf9QgAlhAAA=
Date: Thu, 7 Mar 2024 17:11:41 +0000
Message-ID:
 <SN6PR02MB4157AFF080839DB55294F5E9D4202@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240222021006.2279329-1-rick.p.edgecombe@intel.com>
 <SN6PR02MB41575BD90488B63426A5CAB4D45E2@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To:
 <SN6PR02MB41575BD90488B63426A5CAB4D45E2@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [5PYBSSLBB9owHJIEI6l2DZKlq2VXLzCP]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|LV3PR02MB10150:EE_
x-ms-office365-filtering-correlation-id: ca2c74d8-7fa0-454c-386c-08dc3ec9a8b7
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 lLiq/D11Ksn/zRK7JqfGWm8q9wjy4Cxmohs7SUAvqXeqdu5DRHAELZn9ZGjajhdbUGKOXjZYSX8MrwgbhGsLnYMxYCdIXcxC67+b/do2Qp4UBAFeUUpAvrb5YA8Rf4VVh2oj99HZRM7tbDhhGTC2p+Eu31m2MafBVeOshc9UMLlc+A3/Y2M/6WCMcqc/WQVOA1DYUldg+gehjC2NJ+0xEG+avfDy0Y7xOi9JBl6+CEepICfFKE4gTvp/kHXZ6CO73fBlSeXy8R6wVdyeReCbm7nju9yZ1nHfwl2gVon5X+XbJGsS16GQFlPZSh2te+xUrDFE3CafD3EwMFJ6OqILLyGEu74IbB+4sH3iEa8gtD7aMAyKOw0jvK2i0yaeYf8xn8hXmE0j5jKO9IX3WavYfJT154fSgKQRvQRfs0RBrAc/XDLEVENuyKzlCWwEFt0l8vzvXmmSPVcYeM8DkNvL6/QT9tkncdjLYx0VwkfFcpXkX+FPwLdtwkAjlUTMaukI8Yr1yPlWgLxJfrId65W3vPoJwKRqxcKJ//ySRDcvbCEQonkG5UIqgckiPfZs0G5K
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?EO+MFclRxBiWZmd+3al1ovZRJCH0si8Dn9BgPZFyZQY/57xcV+7NLqt4d9Ql?=
 =?us-ascii?Q?G/0MU8phe0fQhAwrqeTUJGwFO+b/z9F84E24cAHBL5I1W5mW4vpJR7+4Dzdi?=
 =?us-ascii?Q?cOMvoiJGSnBg1WPS2yHczmoGO5b2DF77r6OE0SO418tK60CH2P9Lg+HgPS1X?=
 =?us-ascii?Q?tl8JvCmk5mPe/9sYkKJEa9EMZdbZ7frdtxvvlpLibe4Op6g7z3alRDi2m/gm?=
 =?us-ascii?Q?3kRXEnUKpWa+q8JvlzXIiEPdy/3/NiIutisrIk+Fz2nDwyfp9Ab0NB1mWuPE?=
 =?us-ascii?Q?RqSJDwnlJPOWVtjLLT/DEUoK4JL/BN+Sc8BTQOZyGja/fI9RmWFOTpQVdM99?=
 =?us-ascii?Q?8d3KeL9y1t50WGMvsfOejHcckPC9WcErdNSPxPOgaAhqgfWpysQdTILMJ3IC?=
 =?us-ascii?Q?+FUTiJCx0lL4no2J6Soidq74QARErxs/YTs9lVg+uTbRZXZVRAJjSVtSkYdI?=
 =?us-ascii?Q?SIjS5YHhyMvIjRahAcWMEtUnyXt1vS4jZFWifLpf5Kh9hXEwFgRy/YRTCkwR?=
 =?us-ascii?Q?Q5nK8W+bAzeR/EXaG6EMTRq1OPEOiTjXkly6/2ukGWLPOaOxD7auRbxUK2uF?=
 =?us-ascii?Q?C4KNxY5lfWpnnnqZ9AH32K1+aKh+JNStlSydHNNZaNRiBhtNVJj6I6lGzdsO?=
 =?us-ascii?Q?cvB1MEH95fCdOADTfX9tQkeA2//F5vh8KUwozkjTAcwsZcUzGiaQbOotm4bU?=
 =?us-ascii?Q?BYyKo/ir+wrBf6J3mQzCklYMO4V+dZ9hXSCQJnnKXBXPiTZF9a/QAEJ3WQXF?=
 =?us-ascii?Q?7EmgNWsG8blTC2oWwnpAd9q7XHRXkfw0VNW2vsK1GpdurQUYX+pFdrjIPajC?=
 =?us-ascii?Q?ZgP164j6z8c99Par0iOXVD221qSU/wwBOB1VGNM8vNjtSpeYcuw2fNdxBv1e?=
 =?us-ascii?Q?lI2kmUNdu1yuviWkirs6jV1qNyB25CQE4LCOTmBizqXAaxc5tXt1dmPPIQYv?=
 =?us-ascii?Q?NXTuTKKEbcI0MFWTOPvnnDd2OvrSe/PTV+y3BO/ioe9jOFQktgsCIylOeDHR?=
 =?us-ascii?Q?z/w6orQ3fpGv9Xhd8tso5/HBQ9zVyDH7xVyDf3b8tuXKRJmVSKJNY4oRSNNr?=
 =?us-ascii?Q?AFwJieRr1WAxYYArcth+t2kSwlmykJ9TLzgm/UjW9eAjTS/Gr6qybe1gl58A?=
 =?us-ascii?Q?m/seVAZ5nGGavlIif3eOyRsVqSEQskH6Ks4IRJxvkmsyz3jUnOw0sms/BUMc?=
 =?us-ascii?Q?l5qcyoZ8TYCpLXrItKEdf3B+7BtCx7KfnPVYAA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ca2c74d8-7fa0-454c-386c-08dc3ec9a8b7
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 17:11:41.9311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10150

From: Michael Kelley <mhklinux@outlook.com> Sent: Friday, March 1, 2024 11:=
00 AM
> >
> > IMPORTANT NOTE:
> > I don't have a setup to test tdx hyperv changes. These changes are comp=
ile
> > tested only. Previously Michael Kelley suggested some folks at MS might=
 be
> > able to help with this.
>=20
> Thanks for doing these changes.  Overall they look pretty good,
> modulo a few comments.  The "decrypted" flag in the vmbus_gpadl
> structure is a good way to keep track of the encryption status of
> the associated memory.
>=20
> The memory passed to the gpadl (Guest Physical Address Descriptor
> List) functions may allocated and freed directly by the driver, as in
> the netvsc and UIO cases.  You've handled that case. But memory
> may also be allocated by vmbus_alloc_ring() and freed by
> vmbus_free_ring().  Your patch set needs an additional change
> to check the "decrypted" flag in vmbus_free_ring().
>=20
> In reviewing the code, I also see some unrelated memory freeing
> issues in error paths.  They are outside the scope of your changes.
> I'll make a note of these for future fixing.
>=20
> For testing, I'll do two things:
>=20
> 1) Verify that the non-error paths still work correctly with the
> changes.  That should be relatively straightforward as the
> changes are pretty much confined to the error paths.
>=20
> 2) Hack set_memory_encrypted() to always fail.  I hope Linux
> still boots in that case, but just leaks some memory.  Then if
> I unbind a Hyper-V synthetic device, that should exercise the
> path where set_memory_encrypted() is called.  Failures
> should be handled cleanly, albeit while leaking the memory.
>=20
> I should be able to test in a normal VM, a TDX VM, and an
> SEV-SNP VM.
>=20

Rick --

Using your patches plus the changes in my comments, I've
done most of the testing described above. The normal
paths work, and when I hack set_memory_encrypted()
to fail, the error paths correctly did not free the memory.
I checked both the ring buffer memory and the additional
vmalloc memory allocated by the netvsc driver and the uio
driver.  The memory status can be checked after-the-fact
via /proc/vmmallocinfo and /proc/buddyinfo since these
are mostly large allocations. As expected, the drivers
output their own error messages after the failures to
teardown the GPADLs.

I did not test the vmbus_disconnect() path since that
effectively kills the VM.

I tested in a normal VM, and in an SEV-SNP VM.  I didn't
specifically test in a TDX VM, but given that Hyper-V CoCo
guests run with a paravisor, the guest sees the same thing
either way.

Michael

