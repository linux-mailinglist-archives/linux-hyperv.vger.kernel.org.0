Return-Path: <linux-hyperv+bounces-3165-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3ED79A5970
	for <lists+linux-hyperv@lfdr.de>; Mon, 21 Oct 2024 06:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEEF3B22287
	for <lists+linux-hyperv@lfdr.de>; Mon, 21 Oct 2024 04:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F53191F60;
	Mon, 21 Oct 2024 04:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="PpqUJa1O"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY4PR05CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19010002.outbound.protection.outlook.com [52.103.7.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966D97B3E1;
	Mon, 21 Oct 2024 04:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729484276; cv=fail; b=hHfrSQYVKEMhW46qMD/sVcweWBhQOGKF5OVaWN0ANHb3wuaNM9/Y0Re6d1WTxCaCkIZIdrhzoXpQq6yMUwUkik92ynieOlZzhZLk4dtqCu8tVHOuRWgUdn5mShJ26mwoLK7c0oFEVxGGLxDrkDQ+bFtB0sn0yZdZTx1YZ9WnZ8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729484276; c=relaxed/simple;
	bh=m9mzOspMLx32kNdGmjV7YhPE9t6h1E6cNWpy0gaBkvE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kO4INV8fKlY4RYLILbGRg2j5dC1MlF/28oDxTCgHQuP+rt8/0npbgBLxEpkxtk/RcvEC3iiM+d0ubJC/6AiD3D3bBJp6+2dJKRi8q6Gg678Mp+tpUnmbzye/CKdlXUqokUXpQp1ik2VDwqNEf0Mxl+RmOL5WXoy+DK8AxpNdtz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=PpqUJa1O; arc=fail smtp.client-ip=52.103.7.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=il/kvnPbeBHsrhs/8ydhw5fHuMN4PyGUa/VnhSobAFCtD506qzzn3VuVsrmMaOoCJVkJtnVONJo6lw8xornEsKw3JR97Evdqkus1BrVCQih/fJTixO/IDlit/Ug/7Vsn79rrdtMw/ZOM/kxSJfbdxFZHO94La8qVZ3xkZDrOx/XKb9YrZsJ4gtks5+/hZgi66hNOP/m+1aouARcJ2qkm3qJY0bXl1wQ/GYOzRC5fAV+xOk/qZeooMV6pc0anichwVmwzaS1lp4by1TV1tKZPuozEsFwaGB4iFcV/ybTtW6Ibni2vHxZ1Er424z7GEucV7wRQ2iU2MCu4K6XEdSsj5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNwNxz4bLuG/x6dL+T2ulNt6aadSUIYIiUG6nVwKdhQ=;
 b=WF5pIO5FtSSr7IbVoqRU95Beo0jSQZpc/UK96DYjcMvO/jIsy4+gZscuihwU8T2+GKUwTPEO+P8C31elwFWTYJq8JjQZSCjSHxP4bpxZU3qG3bNvJebFlYIEyBWxBW8taYy93FJanWEYRkoaLgfoHPCN/TdKbXxDKOg+4aOLSoKy5bInKmyfeK4EK4jWvvuJgu6GBC44iKOTZSIw1Y19S5WTJpwDnpnzP6dldFQTxG5f/69gYnsfLx3fikYxty4n5YXLs4wZtADx8kol+xpojk26iXo+g3xDRdWSP2tUAOgq7wAvjkAuzS/a6P06eZgHOpwbnVUD7gUL6MAHlWwk2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNwNxz4bLuG/x6dL+T2ulNt6aadSUIYIiUG6nVwKdhQ=;
 b=PpqUJa1Of+e70tOEto/9eOicqZPBNfwB+s/ou44q7Dg09RbSw2eBWM8Ng+0OgKe5NIukXDb/F6jLt9l7jys08qnZtEKE9Pt36DLEWSbHodX0XxUShFQWhLocZl4j8bXOFCZiohv6t60J+/XIenOAHpNKNk3YYLLvIm7BIfI9DTUl1YmemTDqYURwHso0QvzP1rvGZxJVpQxc4Y6Sb+0JCIvBoPRAgRpB8pDpXagbUCT9QTHQDN+/1SCTPwsxim/uawUWxzKN6Kr2QzrIn7q3MHoBVseME6gxpzMwur2VICRYzswe25hQqzWIraAv61y7dMSldEKgGua6nGGuHxJ94g==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB7774.namprd02.prod.outlook.com (2603:10b6:a03:323::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Mon, 21 Oct
 2024 04:17:50 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8069.016; Mon, 21 Oct 2024
 04:17:49 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Easwar Hariharan <eahariha@linux.microsoft.com>, Praveen Kumar
	<kumarpraveen@linux.microsoft.com>, "lkp@intel.com" <lkp@intel.com>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei
 Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, "open
 list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>, open
 list <linux-kernel@vger.kernel.org>
CC: Naman Jain <namjain@linux.microsoft.com>, Shradha Gupta
	<shradhagupta@linux.microsoft.com>
Subject: RE: [RFC PATCH] drivers: hv: Convert open-coded timeouts to
 msecs_to_jiffies()
Thread-Topic: [RFC PATCH] drivers: hv: Convert open-coded timeouts to
 msecs_to_jiffies()
Thread-Index: AQHbIBwJBzG14C8G4EaRSRcLJGD+C7KMJdaAgAD6CgCAAGB34IADFboAgAAE1xA=
Date: Mon, 21 Oct 2024 04:17:49 +0000
Message-ID:
 <SN6PR02MB41573CB05D8E32C376EB8546D4432@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20241016223730.531861-1-eahariha@linux.microsoft.com>
 <9f4baf14-8182-451d-9849-4326a783d5c1@linux.microsoft.com>
 <2dff61bd-55d8-430f-9d92-6cbfe1bf6326@linux.microsoft.com>
 <SN6PR02MB41573004E0B25DA75F38F0AED4412@SN6PR02MB4157.namprd02.prod.outlook.com>
 <61f0eb38-2f0d-4f0f-a90c-18a02ebf4c55@linux.microsoft.com>
In-Reply-To: <61f0eb38-2f0d-4f0f-a90c-18a02ebf4c55@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB7774:EE_
x-ms-office365-filtering-correlation-id: 3ed06c01-1772-4285-ba85-08dcf1875319
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8062599003|19110799003|6040799012|8060799006|15080799006|102099032|3412199025|440099028|56899033;
x-microsoft-antispam-message-info:
 FCF/qOzvK8z39KjOZ5RiX6jRjS8/c9N/R4tJL8khjwcxpSobAyMCGoLRfMzbiLlFn1zPQCgUCzo+CRu13GlPQzwzQvNIgf/IKe9jACSqzLiZyr2CtwbjlEshkM2GF2/PTZuQnu8Q/DQTdVUMPsZI/VlsZZPmGCvvjDKDxiiLgMgs7EQHx90IoOC8W0Rl51he6uIDLeHROiJl/hz/4PJ+cNfQgXGYsLMYgzoJ6wDRpipC8lfvSa6JzGUBcjCFJk84619k/rItGZtPueUIRKXxJARjRlvlzkBD1QZd5gN+RIMhxlxvqOd5qXpAUprehOzxaGPAhMf6OM7hE75/sRl03QbzjouBJlhi7V77l5+BED6YkyOvUIKHvp38OoLfk2zVyVhmXWTqccZOQBjQm5Hx4DdZp8HRHeE57or7G92x4Uw6LcEifoq/MgvhggMeZZ0N9h5D2Y7cD1TOMWwo+XnbmfT9QZNDTcW+jWOGcwkIOn6t0iUjEh0o1rdjJfMHyFBDMgfiewESD0qWuC7aXtOGciNO8a5L8S1EBzSvAUkIkCZKIPthfYL02sFcCvQDAYS3TidrKbGvRTsXWFjerBj5r93np81ZvRoybREerEz+gCEDRniX8i8tTgeqaVdUz0R6aG2UIVt4I6nJozukQoIqiDzGZk/P+RqzMoegs/GdmkaBaQakqHwNzeSzuG2qbivfFmPH0zv5XnwXPL4meuQ7fPV+LbtFAkCkrH8ZQpwvtUY=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2ePRvRzwbLXTCH7l8eYdwZUW3WsffvK6HQBvRHV66gWRWdrbaCtHJ8/a2bCq?=
 =?us-ascii?Q?RIIors1Nxk3PpHCasdqMTuL+0ktcprCcj9yb4nptWKCmlv1OOy29/dCru2V5?=
 =?us-ascii?Q?HbehBmOaXSCWiwR8QyxxnZS6ATc2xnKxOMbKjOkZsSjVpLTio9p10cikXA7w?=
 =?us-ascii?Q?pZiNIjENqEEKhQQzp9pdqriWxSdrifW0XWRmK3mI6D2DGNnJbxseN7gSQKmo?=
 =?us-ascii?Q?NpxglDBK19nOPTCHPHAVu5p6Rr9jL0LsAr/nEcC9GTWF6o+YRISP0Wy+1wvk?=
 =?us-ascii?Q?dY1cXU9RcDc0Awq4dhWgSVl44+Bxrka2xMRx/ah3L22TJulXX4xA9g0yDMhD?=
 =?us-ascii?Q?BZVmcZjy8ummkrTc+ISGjEk+rcI2dnI+MtYFKISvPKRys/90wClOp/5UhxRs?=
 =?us-ascii?Q?Te50PwkrOF2WYhUOyQEaSnZtgMHg4tjJxTX+St0uT7AmJN2OIKO6OZjTLOCv?=
 =?us-ascii?Q?6ACaKvJGYC+vVdazHoJEunfYEIr6r2+i1dhjIIZZYlxU4HlwZUZlXW4qkrui?=
 =?us-ascii?Q?iDWOSuQt6pyqaWwJroTcnQAfWdQ+trrR7V8sDBY5a+cauOlkui7Z4OdPjNQm?=
 =?us-ascii?Q?Ym6vV3u+yGqAjUT9ZLp4PdOxToFVOV/mMv8K8ZWI9aP3M5+6ZdjCiLJsWewi?=
 =?us-ascii?Q?G/95ygmSpvpi+ZPwE1tJh6GQ39qrTCt2Nt/63CiqKNEOwdYzASwbsryDPBiS?=
 =?us-ascii?Q?lN0wNsucqrAyVHJ33qMxC+qPnzKqqISQs7P/4F4SgziebfEQWMK06N4qrEqx?=
 =?us-ascii?Q?3z8CLp7qmnuRNDovbAPgY4j3NUgEvumA0enSWmyFz/FH77nn4g6KWUbCY2/W?=
 =?us-ascii?Q?GQ/9G6DRuEU9fTFeg9T2rKsAi3TUOM6G2IS8PH7QyoyLWfa1zQEvnq4l3v1A?=
 =?us-ascii?Q?dRkaRNBeloDL7Ma7k3MF6lWC1S4vc264DTA7iiTfLvcVAW4uJPUIgXPLBCX/?=
 =?us-ascii?Q?gGieI/qxY3+Jxmb8sc+l5mvmM7Xq2V/QQhuT2uuRLGKfE4wXwEmrDndGxRoF?=
 =?us-ascii?Q?UDR/y3Kl8Ye6+CjkGC4xpljVGrR+nGh8pP1qVpZsl6S/dvotqqqryni+KP0H?=
 =?us-ascii?Q?BSPvFHhW/LyCmnRYEkYf8ZuWgIXvOgrcsEKsvGadPRL4NX5O0AwxLslsiEj/?=
 =?us-ascii?Q?DAXZFq0+vULtbbNcjZ1yu7IE7t5HFlFrNzN0wzJDRdERVveyQjeMxHKsYzK/?=
 =?us-ascii?Q?ZhinGb2Gva5Lcwzv8nD25k6RBewZ4e6g/zQRgvZ/vch+tnccwOg8DhwqD6Y?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed06c01-1772-4285-ba85-08dcf1875319
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2024 04:17:49.6382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7774

From: Easwar Hariharan <eahariha@linux.microsoft.com> Sent: Sunday, October=
 20, 2024 8:42 PM
>=20
> On 10/18/2024 9:59 PM, Michael Kelley wrote:
> > From: Easwar Hariharan <eahariha@linux.microsoft.com> Sent: Friday, Oct=
ober 18, 2024 3:50 PM
> >>
> >> On 10/18/2024 12:54 AM, Praveen Kumar wrote:
> >>> On 17-10-2024 04:07, Easwar Hariharan wrote:
> >>>> We have several places where timeouts are open-coded as N (seconds) =
* HZ,
> >>>> but best practice is to use msecs_to_jiffies(). Convert the timeouts=
 to
> >>>> make them HZ invariant.
> >>>>> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> >>>> ---
> >>>>  drivers/hv/hv_balloon.c  | 9 +++++----
> >>>>  drivers/hv/hv_kvp.c      | 4 ++--
> >>>>  drivers/hv/hv_snapshot.c | 6 ++++--
> >>>>  drivers/hv/vmbus_drv.c   | 2 +-
> >>>>  4 files changed, 12 insertions(+), 9 deletions(-)
> >>>>
> >>>> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> >>>> index c38dcdfcb914d..3017d41f12681 100644
> >>>> --- a/drivers/hv/hv_balloon.c
> >>>> +++ b/drivers/hv/hv_balloon.c
> >>>> @@ -756,7 +756,7 @@ static void hv_mem_hot_add(unsigned long start, =
unsigned long size,
> >>>>  		 * adding succeeded, it is ok to proceed even if the memory was
> >>>>  		 * not onlined in time.
> >>>>  		 */
> >>>> -		wait_for_completion_timeout(&dm_device.ol_waitevent, 5 * HZ);
> >>>> +		wait_for_completion_timeout(&dm_device.ol_waitevent, msecs_to_jif=
fies(5 * 1000));
> >>>
> >>> Is it correct to convert HZ to 1000 ?
> >>> Also, how are you testing these changes ?
> >>>
> >>
> >> It's a conversion of milliseconds to seconds, rather than HZ to 1000. =
:)
> >> msecs_to_jiffies() handles the conversion to jiffies with HZ. As Naman
> >> mentioned, this could be equivalently written as 5 * MSECS_PER_SEC, an=
d
> >> would probably be more readable. On testing, this is only
> >> compile-tested, and that's part of the reason why it's an RFC, since I=
'm
> >> not 100% sure every one of these timeouts is measured in seconds. Hopi=
ng
> >> for folks more familiar with the code to take a look.
> >>
> >
> > I believe the current code is correct.  Two things:
> >
> > 1) The values multiplied by HZ are indeed in seconds. The number of
> > seconds are somewhat arbitrary in some of the cases, so you might
> > argue for a different number of seconds. But as coded, the values
> > are in seconds.
>=20
> Thanks for reviewing, Michael, and for the confirmation.
>=20
> >
> > 2) Unless I'm missing something, the current code uses the correct
> > timeout regardless of the value of HZ because the number of jiffies
> > per second *is* HZ.
> >
> > As such, it might help to be explicit in the commit message that this
> > patch isn't fixing any bugs.
>=20
> Will do.
>=20
> > As the commit message says, the patch is
> > to bring the code into conformance with best practices. I presume
> > the best practice you reference is described in
> > Documentation/scheduler/completion.rst.
> >
> > I don't understand the statement about making the code "HZ invariant",
> > which I think came from the aforementioned documentation.  Per
> > my #2 above, I think the existing code is already "HZ invariant", at
> > least for how I would interpret "HZ invariant".
> >
>=20
> That's right, both the best practice and the statement of HZ-invariance
> came from the scheduler documentation you pointed out. While I can't
> find the source with a quick search right now, I understand that HZ
> varies with CPU frequency and I figure that's what the statement is
> referring to. Unfortunately, there wasn't any discussion on
> HZ-invariance I can find on the lore thread where the statement was
> added. [1] It seems to be one of those "it's so self explanatory it
> doesn't warrant a mention" unless you're one of today's 10,000. [2]

No, HZ is not related to the CPU frequency. HZ is a compile-time fixed
value specified in the .config file.  grep for HZ in the .config file. The
allowed values are 100, 250, 300, and 1000. The jiffies code is set up
so the number of jiffies per sec is HZ. So specifying "5 * HZ" (for
example) as a jiffies value means 5 seconds, regardless of which=20
value of HZ the kernel was compiled with. In my interpretation, that
means using "5 * HZ" as a jiffies value is "HZ invariant".

HZ (or some predecessor) originated back in the day when physical
hardware did not offer high precision timers like it does today. Timer
hardware generated "ticks", and ticks were normalized across a wide
range of hardware to occur at frequency HZ. Usually that meant a
timer interrupted HZ times per second. I don't know the full history here,
but jiffies were the coarse measure of the passage of time in the kernel,
so mapping jiffies to HZ made sense. Older internal kernel APIs use
jiffies, mostly for historical reasons even though much higher resolution
timers are usually available. And there may be additional nuances here
that I'm not aware of.

>=20
> > Regardless of the meaning of "HZ invariant", I agree with the idea of
> > eliminating the use of HZ in cases like this, and letting msecs_to_jiff=
ies()
> > handle it. Unfortunately, converting from "5 * HZ" to
> > "msecs_to_jiffies(5 * 1000)" makes the code really clunky. I would
> > advocate for adding something like this to include/linux/jiffies.h:
> >
> > #define secs_to_jiffies(secs)    msecs_to_jiffies((secs) * 1000)
> >
> > and then using secs_to_jiffies() for all the cases in this patch. That
> > reduces the clunkiness. But maybe somebody in the past tried to
> > add secs_to_jiffies() and got shot down -- I don't know. It seems like
> > an obvious thing to add ....
> >
> > Michael
>=20
> From a quick search on lore with dfb:secs_to_jiffies, it doesn't look
> like anyone has tried to add secs_to_jiffies() to jiffies.h. There is
> one instance of secs_to_jiffies() being defined in
> net/bluetooth/hci_event.c, added in 2021.

That's interesting!  Somebody else had the same idea. Move that
to the jiffies.h file, and then use it in your patch.

Michael

