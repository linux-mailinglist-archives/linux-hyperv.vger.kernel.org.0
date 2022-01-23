Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6284975E0
	for <lists+linux-hyperv@lfdr.de>; Sun, 23 Jan 2022 23:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240243AbiAWWCO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 23 Jan 2022 17:02:14 -0500
Received: from mail-eus2azon11021022.outbound.protection.outlook.com ([52.101.57.22]:39991
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234697AbiAWWCN (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 23 Jan 2022 17:02:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YcwdRVr0vjzJLCqjEDYaZY4rqh9rNwPmIxHXSManxsOP9x1LxElXjRYVC9ULvo0ql9aCvMCboGR/9zPQVG6jadr9kaqSIhZJSu2z+16ZsKFHv1JzV5qfeWUpYo/EPY6XESSmF2XY+B43lcSg2giPwpixvFy0xESNv5UA7V4SxZ3LWDQ7OM1Et4Hkh4qQRQIjXUXIgpGebvypQJ3qcoO5lvqKJ5gJD+50VvHRrKqOdOJg89y1Lrc8TG6q9F4yeiL51lqG9RjHhKgJbJBiNzoHbR8QAtBp7417LEGoGLOvuDbtoSdS3S3Cww6s61LowsbXNSh856ULwrMo4hSGLlIrbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTTA3TYawVIIlVINYsewsKqMNU2XcOBfcKBpYbj7TBA=;
 b=kbgdQF3A/+G7UWBl1loEPglCB5lw6sTc4rGNHqEtWM8YdjapYjB5LDbfb6tACPY35j3FylvV7xr65SLz/6C3RY2KBbInDBBoMLXfKTe6qe3xPXOgNmbA09KItOeJhTaJsPE/DAE2wfNjqgYDA/yH/lxK0NKa84EeR4IZeciHmAzqVfgMb0V/nE9n3YI9khdYQ+mAtm+73/38YgOua8+wzDQZ7ZxQqqv0Kv3zReEqGtBPbfLwSm7vZ0CB8v9UK0LNXyXx41gRWfr6sjGQxbAmUt0NTqT2qqPs1Q5z4dERZddQ2kHyvRDJe4EdcKR3I6tudEVJAwylebELMZQShCV4Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTTA3TYawVIIlVINYsewsKqMNU2XcOBfcKBpYbj7TBA=;
 b=F2U+oLzHjbgKskd36V+18KyWNl3a93VNdQXGzttboMvspki+rhturCsVA4IiEiAvQcbk8L4YhkTZfXL/2/dk3vmbISq7QHQSHvKeRXrcYBl2WmFhKEWbzHZIanaa0VSF6ShTsRE2gHGFA6beKKgdFM+WeVenJ/SIyvZXi9jQnko=
Received: from MN2PR21MB1295.namprd21.prod.outlook.com (2603:10b6:208:3e::25)
 by SJ0PR21MB1999.namprd21.prod.outlook.com (2603:10b6:a03:299::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.7; Sun, 23 Jan
 2022 22:02:09 +0000
Received: from MN2PR21MB1295.namprd21.prod.outlook.com
 ([fe80::d1ac:adcd:9b00:28fc]) by MN2PR21MB1295.namprd21.prod.outlook.com
 ([fe80::d1ac:adcd:9b00:28fc%8]) with mapi id 15.20.4909.004; Sun, 23 Jan 2022
 22:02:09 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH 43/54] drivers/hv: replace cpumask_weight with
 cpumask_weight_eq
Thread-Topic: [PATCH 43/54] drivers/hv: replace cpumask_weight with
 cpumask_weight_eq
Thread-Index: AQHYEIjseMEfWodowkK36SzktkggO6xxKAqg
Date:   Sun, 23 Jan 2022 22:02:09 +0000
Message-ID: <MN2PR21MB12954BFF215726B0E6C3C253CA5D9@MN2PR21MB1295.namprd21.prod.outlook.com>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
 <20220123183925.1052919-44-yury.norov@gmail.com>
In-Reply-To: <20220123183925.1052919-44-yury.norov@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4119fcae-a908-4af5-bb81-945771b82db6;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-01-23T21:59:54Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28965adb-ef8a-4ffc-a93a-08d9debc00ac
x-ms-traffictypediagnostic: SJ0PR21MB1999:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <SJ0PR21MB1999B8DCA12CF1D668F45E6CCA5D9@SJ0PR21MB1999.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0rPFrixneQS1Y0ym7D3Um09h0kMJXgD66YPlwS0QVKp3Kg6uOkCSh/4mtigWtjWPwwd0d6Airib8SHNd1eYpmChYfwfsULJUf8cD8IBNcytghJBkWtxM4RrJ8LpE1Ahd9mlwV+ZCKJOqw+S+NmBe6Es12BdQAWYEZfurH7PcOGd0y+aEE1EE6NytY1qcdrxtaUXufWvA2HqqS+PINmcmhqtMEYPSUKj7WGnI763/ji3eymnEOR8G6vxxvjIiaRM5tSrYW/0oTKeSaLDoYBirIRq8cDM/UJTheYjzX/ekC26YgMQ2c0cNUEVw8/Nu+ycgBqn5dWYoUtRevXX7HnH7po2aeyfwecv4GE6KcpUJPms7oWpFT21ZJuMTp3yqw9jn0ew7g8SopmSdl3ARHPymxdZK1sDJGOwCLb9SaUZTylRXdxEbFyhsbEIBQ2g+hltxHNi3DlVQikk+VWxD7Z6RQs+bElfaxRUdZCOU+Q1o8JrD4jZyy0lqMdSsxyzxvS4kV9f9AXdRg+yLhWadu+y9PIevdp+JxpA++1Uv7Un++l25ROcv28uWMuz9JURTqoKKrJ9sUjDjpOciyNvFptugIQqzIH5/jqWPOw7GmbGVDyt3sgqL0u3e5rJ2PmtgRl5VX6aJU/oHzr8fBHj+9oajKwl6wjv096inRAf9uGLid3Myxlz1glrySOaDbLBgy4wa9Y4v86pEK9Qfa42/7AI0CVSdePd09m7Gm2YLxYNGfbRUMQNXac0w5BqAwk1bxJuHqHpLgJqaXw4gXkhX7dG4Muue4FdeFawITSZQFply5Ng=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR21MB1295.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(110136005)(921005)(316002)(38070700005)(83380400001)(82950400001)(82960400001)(26005)(76116006)(186003)(38100700002)(7416002)(66556008)(8676002)(2906002)(9686003)(8936002)(52536014)(55016003)(86362001)(66446008)(8990500004)(6506007)(53546011)(33656002)(71200400001)(66946007)(5660300002)(7696005)(10290500003)(508600001)(66476007)(64756008)(122000001)(16393002)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?J7TM2GxxQeKoTaHmR1O9ixgicfilw9rZHmDnYkwyg4KlQY0DzBFwTBqCS5?=
 =?iso-8859-2?Q?XilsA19vhC4dsrBNv1JxDGoX0URcHF5FGT01EpAP9d99h7e5H/fO/QsypV?=
 =?iso-8859-2?Q?hWAwXAwc4V8HE32935PQ4kCulAjUlAzxDf05H/E9rXthtt7wTfEXFb+NOB?=
 =?iso-8859-2?Q?sZ2JyDhn9iO3AuvQOz4fl13jE5ofAUs0q1F+QqNEbsIuynvvaNxcQVQgoh?=
 =?iso-8859-2?Q?rrPArFPabEy/N9WLuM19HSnvEU3p1PnBlydB95SnGi0Xsh0HaglxGSujkx?=
 =?iso-8859-2?Q?kBshDR8xjq+ddtVtRH4CR3LFwv7NyLn/0d7MSg37aOJgu+59IZh0b3fzvv?=
 =?iso-8859-2?Q?HVORR2oDiaDMwXKZKwslRWGgDK+nCU0wpkftN6P2kyUCLZp04VmuNwLvTc?=
 =?iso-8859-2?Q?UMqkw4D4CxfLiPWOrf89bbKDEfjjKBVQ+O5ykybvDP2KuRsEfo9viFKUpE?=
 =?iso-8859-2?Q?l6FPCsKeZP+mZ9hfi0lDYPuD3kAhPUg/OJCOBM86UWrAo/QiU8INs/oORQ?=
 =?iso-8859-2?Q?fKfm9s2iC44N/W7hfJSKU8/ZDTN9ZJusvo3qi1dB+UuWAM92U16yxUVddN?=
 =?iso-8859-2?Q?bd1Tue67M5XK6HX12uGWHp8IUaVyyQTzGTt9Oj/bsnJ9MPNUc42aCqARDI?=
 =?iso-8859-2?Q?RPQpizOVlKzotVnoEt2IQAHpfZ/yHnQBMiZe0KgzlgG/AXgoz8ToLD5BF9?=
 =?iso-8859-2?Q?BLSPZLLhkcuEtJiyu+fnHtRY6IKjrZXdhdshEeRtqUabehpkTfTf8Wy2IK?=
 =?iso-8859-2?Q?IYQdBKRNi5hgD3Jd8oxMsh/ccuSp52V9KUDYOHPErqxv5SP9yCvAyQti7N?=
 =?iso-8859-2?Q?/0OpKzCgnJUWigWmFHViu3lLkJfBwflGr1iO5NJDKwWhvkBEXB89L2BHM/?=
 =?iso-8859-2?Q?z0h0+6EbbYpzgetX6VGoAIDHNhFLK+d7LCDU7TvoDL8XWh1rtn5ikq9vRX?=
 =?iso-8859-2?Q?5kk4G8nKuW2M7zcuuRvSVoECiJwV1pB5o3oua1HDBksdFT+v73i9d9xLlt?=
 =?iso-8859-2?Q?bDQTqvO063VWUpzOJg91wi+W64CqZK85OzEVl5Ytp4hrVjKq0xLXNekRJS?=
 =?iso-8859-2?Q?bNPiw2C4fFseSQ2uA4DreqmNcfFPCJgvhBt77Q1wAEfxHaZVEGPKfojlqC?=
 =?iso-8859-2?Q?V5srZpQpif8Gl2C4KvnPjqyHf27XSpqtceYhYesg4LAqzBhkhyUegSVpC+?=
 =?iso-8859-2?Q?hmp9/ntcrApNQmrgqPjpMIvVylJjS6L1O3GWnSplbQKFGow5zUupORQXKF?=
 =?iso-8859-2?Q?KMM8vJuln9SkHXr7GrYqA9TzUWefPmhIaM6MeqIqwacGcWMsHF5wcI+5RC?=
 =?iso-8859-2?Q?3uELUIRUy1zxgd/fQnZvjaQzrTBk74x3rGBeYumzW14S6TQAEeWVN/dQ1J?=
 =?iso-8859-2?Q?ThxRWgKD/Cm0+dA9S51/ya5Z7IFIEPnVPCcuk7ppc6ECCuQ1QzTBn3ZPpV?=
 =?iso-8859-2?Q?CmRV5BvymKBlOjpHWDH3UEsjYki7qt4pmio3iCOsABnLTjUmydcppLAkJ6?=
 =?iso-8859-2?Q?O+wX4zw2YQTA22vGRMhMcH9AV72CtHr44jC87vuyfift+VIIu2L1YN4/mH?=
 =?iso-8859-2?Q?7AhRwR4ecaLNUZVIEj1nspPbgwhlyiXhCqbkuTHxI8GKlNJbFLucieVPRQ?=
 =?iso-8859-2?Q?3DWsKU1aYGs4QdTCrx3i6qnhFuAZqfTBXmYGG4577aamZs4NO3+xuEtg?=
 =?iso-8859-2?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR21MB1295.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28965adb-ef8a-4ffc-a93a-08d9debc00ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2022 22:02:09.4269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f8/DrsV77PqlQv65XetkBIfENf8Lwl072yZ8RdyLIZ3UV/cO7sb9glVRPyw76Zg/31fOIyP6uPTRggOXlnJQVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB1999
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: Yury Norov <yury.norov@gmail.com>
> Sent: Sunday, January 23, 2022 1:39 PM
> To: Yury Norov <yury.norov@gmail.com>; Andy Shevchenko <andriy.shevchenko=
@linux.intel.com>;
> Rasmus Villemoes <linux@rasmusvillemoes.dk>; Andrew Morton <akpm@linux-fo=
undation.org>;
> Micha=B3 Miros=B3aw <mirq-linux@rere.qmqm.pl>; Greg Kroah-Hartman <gregkh=
@linuxfoundation.org>;
> Peter Zijlstra <peterz@infradead.org>; David Laight <David.Laight@aculab.=
com>; Joe Perches
> <joe@perches.com>; Dennis Zhou <dennis@kernel.org>; Emil Renner Berthing =
<kernel@esmil.dk>;
> Nicholas Piggin <npiggin@gmail.com>; Matti Vaittinen <matti.vaittinen@fi.=
rohmeurope.com>;
> Alexey Klimov <aklimov@redhat.com>; linux-kernel@vger.kernel.org; KY Srin=
ivasan
> <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>; Stephen Hemm=
inger
> <sthemmin@microsoft.com>; Wei Liu <wei.liu@kernel.org>; Dexuan Cui <decui=
@microsoft.com>;
> linux-hyperv@vger.kernel.org
> Subject: [PATCH 43/54] drivers/hv: replace cpumask_weight with cpumask_we=
ight_eq
>=20
> init_vp_index() calls cpumask_weight() to compare the weights of cpumasks
> We can do it more efficiently with cpumask_weight_eq because conditional
> cpumask_weight may stop traversing the cpumask earlier (at least one), as
> soon as condition is met.
>=20
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  drivers/hv/channel_mgmt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index 60375879612f..7420a5fd47b5 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -762,8 +762,8 @@ static void init_vp_index(struct vmbus_channel *chann=
el)
>  		}
>  		alloced_mask =3D &hv_context.hv_numa_map[numa_node];
>=20
> -		if (cpumask_weight(alloced_mask) =3D=3D
> -		    cpumask_weight(cpumask_of_node(numa_node))) {
> +		if (cpumask_weight_eq(alloced_mask,
> +			    cpumask_weight(cpumask_of_node(numa_node)))) {
>  			/*
>  			 * We have cycled through all the CPUs in the node;
>  			 * reset the alloced map.

Thanks.

Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>

