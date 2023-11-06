Return-Path: <linux-hyperv+bounces-708-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 105F17E2BC6
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Nov 2023 19:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73A84281728
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Nov 2023 18:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041832C86F;
	Mon,  6 Nov 2023 18:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="SF2vXWmL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333F1156E1
	for <linux-hyperv@vger.kernel.org>; Mon,  6 Nov 2023 18:18:54 +0000 (UTC)
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021007.outbound.protection.outlook.com [52.101.56.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0721BF
	for <linux-hyperv@vger.kernel.org>; Mon,  6 Nov 2023 10:18:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZS0LcQM01XUwTKBpd69nl9q6ceNffSEhqqnxx06lufuYS+tp0YSrpqm9Wes3znNDwKaeGD6Jb+4QazDLWTFDi5Reyt2CMREtIEP+JJeTrxb/m4FYwba4Rp2xNUDkRYB9RN1hTFXYKt0O9gT/i77aTulIRouydPDPIbMRAPMiAG49KGXEOk9uq9JtcebGihzZG6/x4cil+BnYWvnaIIV5OJ1orEe9gPMMf4DdIkkfBUgrF52LarXNl650tX1THFbZiND7REbQArFLhN8qEvOBIBnZoUuX4xO5HZDOklmYPDzUsDLGzli0bXBwb43l1MuRTGQ5tw3p58MB6sROu1/rtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zl5DLxk7mTF8ShvshYYsSqHC6O3B+TA6rG+qLvjZcQY=;
 b=Amxd2GYbPEWd9dFLLoSZHyDwuqoAnIWLLK9viz4GDC02PK/otI0Bl5Qm7DHYsuDSzpO88E/pOrxTo9ogkmVq8ZZTCoiRX5AG5uvpiaGaIuEXrW5ud2S760p/VQTBFSY2B1XzcYBZ9MB3rE7tKxP16xT1eypw/tT0jxPj7UPZh71lR/IYO7zL/Ysbr6Bp8nAeZlmliBuhekfwm7m4PEDfr3MD/yIdb6iiXYv6it9+ABDrn+XrWTZkxFlIVHBcGL7hwMXrAsnmWqsBrT7+cdZXl1N3tho2QLeRBQ9WA1FKJqrodSFaX5uiRe3AKr34xTcUZWKK74Vqqh23UAF09QY+VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zl5DLxk7mTF8ShvshYYsSqHC6O3B+TA6rG+qLvjZcQY=;
 b=SF2vXWmLzzPZaWx9yXj0oWoS+hW41SVU13saIu+OJH7EelYFwy/a2uk41UP/FWmNfRe2Vp1NvpU1imJlOvPkIxOp5xXu7mtA67Q/ZAC+81kXx06a1+UmsrmsMe6/YZ5Be7X0xiwSo7k18S2Q/WhWClHTXOms6w+ArNnyB1MpoCA=
Received: from CY5PR21MB3660.namprd21.prod.outlook.com (2603:10b6:930:2c::12)
 by MN0PR21MB3264.namprd21.prod.outlook.com (2603:10b6:208:37c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.0; Mon, 6 Nov
 2023 18:18:49 +0000
Received: from CY5PR21MB3660.namprd21.prod.outlook.com
 ([fe80::75f6:2d3a:9d7b:3b08]) by CY5PR21MB3660.namprd21.prod.outlook.com
 ([fe80::75f6:2d3a:9d7b:3b08%4]) with mapi id 15.20.7002.000; Mon, 6 Nov 2023
 18:18:48 +0000
From: Peter Martincic <pmartincic@microsoft.com>
To: Wei Liu <wei.liu@kernel.org>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "Michael
 Kelley (LINUX)" <mikelley@microsoft.com>, Boqun Feng
	<Boqun.Feng@microsoft.com>, Wei Liu <liuwe@microsoft.com>
Subject: RE: [EXTERNAL] Re: [PATCH] hv_utils: Allow implicit
 ICTIMESYNCFLAG_SYNC
Thread-Topic: [EXTERNAL] Re: [PATCH] hv_utils: Allow implicit
 ICTIMESYNCFLAG_SYNC
Thread-Index: AdoJEw5M5b78JMRkR66oXEcz4znQTAHPdGMAACMUrzA=
Date: Mon, 6 Nov 2023 18:18:48 +0000
Message-ID:
 <CY5PR21MB3660C276E3A8A20167B7644AD5AAA@CY5PR21MB3660.namprd21.prod.outlook.com>
References:
 <CY5PR21MB366066CE916AEB5289153F09D5DCA@CY5PR21MB3660.namprd21.prod.outlook.com>
 <ZUhByoXhvb3ZowPH@liuwe-devbox-debian-v2>
In-Reply-To: <ZUhByoXhvb3ZowPH@liuwe-devbox-debian-v2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ad744481-606e-45ea-a149-a64cdb2d1bdd;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-11-06T18:15:18Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR21MB3660:EE_|MN0PR21MB3264:EE_
x-ms-office365-filtering-correlation-id: ac8a06cc-e184-41a2-acf6-08dbdef4d248
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 KlBj+2zpI7Xry60yEl1V0/gBqWxc+BG90/P//En9xX6kEB5gaK6DIMi2iBonXKnZ82HcN7Ve3wVOBHkUgNAWEVQqb2as/5J9nsglNpvnUjZiG/bHEF+qGt6jOqrXRTvZL+RMsik9n5Tr3q93Phj704i1j+Cs8CD04dCRaFnMbEpSpHlK2EuT8DNA7LBdCDl/xA0dEiavfa5qksPYmiZVdXRgszVyaUF07wQcpA4dGHlpZ8NO4sVd55pT1ZGkK0AzMF/tdo1S4MCdqDGv/Y2lzgIGlAd6Ueu0DCFZIW3xBZ54EXltB2DO+EJHIRIx8GxtEGCZ+h2k4cx6GjGUuh+gWnvQXTxJuSjO1Ej4quiLkW7eeYepadAncLz1kOt97oA+GWFtKYO1VNhQAC6JvuaTttapBE5q4dL3HkfS1VFEZAGUvw1aJa1EzYaY60TrsTJyOcJcRBTOqOBSlldMjtLX1uGXbWgrCjq8uix/+G9A95Ti1cR2yfZQD76Dyn+Bi2ohIjWhRaqF6e2dl8pLGrWZS7Qo5sC+MUdxC8IVH/XKyOzjvJ1Yth9zYIaznyi6RGLUWz/VjR7aXFRULe0i1bG8N/9DsVUZRtM0PEu2x/vp6VRAD6E1avX4XaKEjyVE1cnygpSVlxt812bmgV0uMtL0rlaOIXfDXs9M6WDJmiAYrIKHiFf+a25avCS3TbyM8J6XU1++yc8ySFjSplUkf/o2BA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR21MB3660.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(366004)(136003)(230922051799003)(230173577357003)(230273577357003)(186009)(64100799003)(451199024)(1800799009)(5660300002)(86362001)(2906002)(76116006)(54906003)(316002)(66946007)(8936002)(64756008)(8676002)(4326008)(66556008)(66476007)(6916009)(66446008)(52536014)(38070700009)(478600001)(8990500004)(41300700001)(33656002)(82950400001)(82960400001)(107886003)(10290500003)(7696005)(6506007)(53546011)(71200400001)(9686003)(55016003)(122000001)(83380400001)(26005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tZnWnBpZUdfHIlUmS05TAgm+vDYMEWnfYg3QYDdW/23h41Ucv9lB5T5CAEiI?=
 =?us-ascii?Q?F+xX5HUnpeZTLN6ZzRhP6WBbBo31eETGZGk6JJS50t919wv4Ar9MYqm3Q38c?=
 =?us-ascii?Q?bDmmbypMswFClzVI9zo9T/c29PCYtXBcG0b9B9nUldH0O0ICXkzcif50RnVE?=
 =?us-ascii?Q?3mz6WuIe8CGFQYsxHyD6eqLE/GA1TCvX4OAokIgYK6wbi5f4DvmYMurYopo/?=
 =?us-ascii?Q?pdVVVZ7BcvyFim+nV3NyPwNQI+R7qiLk1hlWlx//8D5RvCU2oBKsInuYENyw?=
 =?us-ascii?Q?jnOCTQoLhywsN3BwSMIyy4V/DcfUquvhOp9z4ofuZ9G2rdLEZpHP8vXag52r?=
 =?us-ascii?Q?8WB185q2uy8vUAmxitS9cnHLwEaOp/5V5u+BUJmzACpkHvjCdzLmsoDy2IlR?=
 =?us-ascii?Q?Z9xjfBuH4WL8kffIV8PRsWZ7rS+YFarPQJonvj5KWxzaYiAbBRO9vh7PUxpJ?=
 =?us-ascii?Q?Pph2/R2eH1GBC3V2fqtu7pY0kpNVYWnpfcN4PQmlfgZIVNlc5eMtJPrKkT+2?=
 =?us-ascii?Q?WZufwI3NCG6X+CInN6xaFJYMsyrUQF3HJh5AvpmlI/+VVOkblRdwNDY+IWVF?=
 =?us-ascii?Q?XgJDUpCTSoI0Y9Tw7DCoWyUKCIMa9Lpz2YzQp39F9cI07etv3psm4Ss6TvtI?=
 =?us-ascii?Q?pmC1O7VUHo1CD2vzGtK0AjS/I4HPFLcP1BVWpYhX28GDALVIlJMFEO/8w8jc?=
 =?us-ascii?Q?wUgEvluDRLP4k2zbO9OOdOthcDEfdslLaFZc0GhbDM69tSjTM7+DISSn0O2g?=
 =?us-ascii?Q?t+vT0lSGb9GLtvZywXwtv7Pefn4i2uPZVVHLM154HJsnEkZzJ/LG0jfV6222?=
 =?us-ascii?Q?X/8pBRTKnaAmvuWbM0CYoep0i8DoIq3GLUgtJ7EO0paJgQxHhdKJGW1c0+tu?=
 =?us-ascii?Q?hAPGHDn4urRZH/CDRF++1U5bjgtlIAkPEmEwO1HUjRXiXnbgw8ToRlZhRYnJ?=
 =?us-ascii?Q?4p8xuDDNuOGEt+meJD+1ygY9jWzWb40yhnOBY0Dg9MLqZ667P0r4Re+9zVm/?=
 =?us-ascii?Q?RKiPqbyOra6ZsMTdIzScALhnWiEVuQkicJXqexNf/77WHYE66ZHk6yymCJBj?=
 =?us-ascii?Q?xz6i46Oiuwium36Xv4WiwEStTUL1xkPI2qzCtwg034Ht6oqs3TL5tSiJ2o6/?=
 =?us-ascii?Q?HOYFp+yKCEY6sJPHjUHwiHFTy2r2+nMFcgTn4Q4moW8zKiHF2UnUpoDGmJR+?=
 =?us-ascii?Q?s0ojL4HxH5s2fb0RG9W+8z7+tiP0+9ER0Raeh2syDfOWReI/+TUcOYdnRQFe?=
 =?us-ascii?Q?EtzJPeJA8yQQaXj5DUMIy59ZcC4ucZPpiyNNAyG9xlqGngQXi7zf/UZhwjYn?=
 =?us-ascii?Q?52+tvfwbpxzgd1wvws+iRiI2Mx4KZ3plvmA7SLx8KBSQCL4jESWPW2JsvqfI?=
 =?us-ascii?Q?5lkxAud62UiNBCC11oMpxPDmqeTz4t/Jn+TCWEDy2qbVWtNekdWW4wd27IC2?=
 =?us-ascii?Q?ipvLYDEASy55F4pXmdyUvfZPK3n/o4v1wm0BA1mym8QsxKVHpGQzf5EkAj9Z?=
 =?us-ascii?Q?p11kNrHdagMWHcgYGnGWLOGi4D3NEJo8rlX0?=
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
X-MS-Exchange-CrossTenant-AuthSource: CY5PR21MB3660.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac8a06cc-e184-41a2-acf6-08dbdef4d248
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 18:18:48.4148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hTfx0HRQLhEFaDYYXng8ACAkX2P36NmAie74LUfkiIi+QeJA2VQuUCc2IlFaqx4lagW8kfZ1jPnYB8Gi3sf9bwwoRq4wuK6p0ilfZLL0iHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3264

Sorry for the formatting/recipient/procedure mistakes. I've an updated comm=
it message based on feedback from Michael. I'll wait to hear back from you =
and Boqun before I post V2/updates.

Thanks again,
Peter

-----Original Message-----
From: Wei Liu <wei.liu@kernel.org>=20
Sent: Sunday, November 5, 2023 5:31 PM
To: Peter Martincic <pmartincic@microsoft.com>
Cc: linux-hyperv@vger.kernel.org; Michael Kelley (LINUX) <mikelley@microsof=
t.com>; Boqun Feng <Boqun.Feng@microsoft.com>; Wei Liu <liuwe@microsoft.com=
>; Wei Liu <wei.liu@kernel.org>
Subject: [EXTERNAL] Re: [PATCH] hv_utils: Allow implicit ICTIMESYNCFLAG_SYN=
C

On Fri, Oct 27, 2023 at 08:42:33PM +0000, Peter Martincic wrote:
> From 529fcea5d296c22b1dc6c23d55bd6417794b3cda Mon Sep 17 00:00:00 2001
> From: Peter Martincic <pmartincic@microsoft.com>
> Date: Mon, 16 Oct 2023 16:41:10 -0700
> Subject: [PATCH] hv_utils: Allow implicit ICTIMESYNCFLAG_SYNC
>=20
> Windows hosts can omit the _SYNC flag to due a bug on resume from=20
> modern suspend. If the guest is sufficiently behind, treat a _SAMPLE=20
> the same as if _SYNC was received.
>=20
> This is hidden behind param hv_utils.timesync_implicit.
>=20
> Signed-off-by: Peter Martincic <pmartincic@microsoft.com>

Boqun, what do you think about this patch?

> ---
>  drivers/hv/hv_util.c | 31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c index=20
> 42aec2c5606a..158f5ff4b809 100644
> --- a/drivers/hv/hv_util.c
> +++ b/drivers/hv/hv_util.c
> @@ -296,6 +296,11 @@ static struct {
>         spinlock_t                      lock;
>  } host_ts;
>=20
> +static bool timesync_implicit;
> +
> +module_param(timesync_implicit, bool, 0644);=20
> +MODULE_PARM_DESC(timesync_implicit, "If set treat SAMPLE as SYNC when=20
> +clock is behind");
> +
>  static inline u64 reftime_to_ns(u64 reftime)  {
>         return (reftime - WLTIMEDELTA) * 100; @@ -344,6 +349,29 @@=20
> static void hv_set_host_time(struct work_struct *work)
>                 do_settimeofday64(&ts);  }
>=20
> +/*
> + * Due to a bug on Windows hosts, the sync flag may not always be sent o=
n resume.
> + * Force a sync if it's behind.
> + */
> +static inline bool hv_implicit_sync(u64 host_time) {
> +       struct timespec64 new_ts;
> +       struct timespec64 threshold_ts;
> +
> +       new_ts =3D ns_to_timespec64(reftime_to_ns(host_time));
> +       ktime_get_real_ts64(&threshold_ts);
> +
> +       threshold_ts.tv_sec +=3D 5;
> +
> +       /*
> +        * If guest behind the host by 5 or more seconds.
> +        */
> +       if (timespec64_compare(&new_ts, &threshold_ts) >=3D 0)
> +               return true;
> +
> +       return false;
> +}
> +
>  /*
>   * Synchronize time with host after reboot, restore, etc.
>   *
> @@ -384,7 +412,8 @@ static inline void adj_guesttime(u64 hosttime, u64 re=
ftime, u8 adj_flags)
>         spin_unlock_irqrestore(&host_ts.lock, flags);
>=20
>         /* Schedule work to do do_settimeofday64() */
> -       if (adj_flags & ICTIMESYNCFLAG_SYNC)
> +       if ((adj_flags & ICTIMESYNCFLAG_SYNC) ||
> +           (timesync_implicit &&=20
> + hv_implicit_sync(host_ts.host_time)))
>                 schedule_work(&adj_time_work);  }
>=20
> --
> 2.34.1
>=20

