Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACD84C18FB
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Feb 2022 17:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243000AbiBWQqj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 23 Feb 2022 11:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243004AbiBWQqi (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 23 Feb 2022 11:46:38 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-cusazon11020023.outbound.protection.outlook.com [52.101.61.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB25A9A66;
        Wed, 23 Feb 2022 08:46:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CPLXs6obgpTC34NumgnOjTUD19YGp9eOlDu9SuKBA/hG4WfLnqz+pGWrn/wVau8ehZHE898pTC3LuNJaAKwOnN9Fz7LPALuKV8BXldHY8KY1YG6oZG0vDDE6CauAd75LFvIaLhfMpXEGgZZ85G49+MYTF7Ql9jDy47xvKK+oqLLOc1AhClC6frNbc8kl0e4swXofpK5vuSkVJMN7cQXECJ97yhK8VGVKZDUW9ec+4TUOr0XQNnrFoZmjGE3bN0PfEKDMUmNNQbqKc47HcV3loe3lKeSYAayFqzHF4aE04vpG92d/akDcFuMwpwmqiEvXVE2lvGjqWItvrGkbcrKPPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KM0EK6Sy332l4oBiPRA+ZwIH1TUCfUnjG/r1233GBsg=;
 b=aekfbsgNIduP04QtAey8fPvwHRJ2/jVWnlCanuNYRIGlPqNqGFP5a+xTj6k5mAmbXuR2ghKQ6NsHp3FMX5EenIW0MLkirk5akUJYKN2tTSya2qcveUCkusKTcbNP4Sj5C1tIy9baqxR+xhTm5weilgCilPUIYkqdpPahCzGZRZqqZJlLVy5PEGUIEXCkpFRYWe22uIv65yrSLgppTJVbMknoqNftRDUssKPpxYo/zgmdbhVVzrE6/amc0NUubBAbi3Koi3CKaa0NzelAYEb5+vHfReMjRWodE/4EReFvoCHgA2Es6op5gzHRaaYcO4RerQZkZizV3Ew80HxjIDEPxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KM0EK6Sy332l4oBiPRA+ZwIH1TUCfUnjG/r1233GBsg=;
 b=EOniP5GvgAoqQoOVCkV3kmly0iu+nu2xS9pI7ca2i2/TbUqg5AhNBDcWDU8iN83uwHgDt77tteQeT252yoFa2vpO0eAkHd7TkGnjzLdpZkdwMbABqKQIbMeXTFGQva8SfiCQ633mheI5DN1n3dulppHWPeyrfP0QHyAJQSPO77M=
Received: from MN0PR21MB3098.namprd21.prod.outlook.com (2603:10b6:208:376::14)
 by MW4PR21MB1876.namprd21.prod.outlook.com (2603:10b6:303:64::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.6; Wed, 23 Feb
 2022 16:45:58 +0000
Received: from MN0PR21MB3098.namprd21.prod.outlook.com
 ([fe80::69f8:51be:b573:e70c]) by MN0PR21MB3098.namprd21.prod.outlook.com
 ([fe80::69f8:51be:b573:e70c%5]) with mapi id 15.20.5038.006; Wed, 23 Feb 2022
 16:45:58 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Boqun Feng <boqun.feng@gmail.com>, Wei Liu <wei.liu@kernel.org>
CC:     vkuznets <vkuznets@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        David Hildenbrand <david@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC 1/2] Drivers: hv: balloon: Support status report for larger
 page sizes
Thread-Topic: [RFC 1/2] Drivers: hv: balloon: Support status report for larger
 page sizes
Thread-Index: AQHYKLeJg+8RSHv6wUeNJm5Kzv2CsqyhV+ng
Date:   Wed, 23 Feb 2022 16:45:58 +0000
Message-ID: <MN0PR21MB3098E9D0243585697977B92AD73C9@MN0PR21MB3098.namprd21.prod.outlook.com>
References: <20220223131548.2234326-1-boqun.feng@gmail.com>
 <20220223131548.2234326-2-boqun.feng@gmail.com>
In-Reply-To: <20220223131548.2234326-2-boqun.feng@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=13fe75be-5deb-4091-90ba-994c1a900793;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-02-23T16:44:50Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 44f859dd-70ef-4531-b5dc-08d9f6ebf7bb
x-ms-traffictypediagnostic: MW4PR21MB1876:EE_
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <MW4PR21MB187661E69CCD1D2B059DED9BD73C9@MW4PR21MB1876.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Acv6KVapzZ9CfkyCPwxXhPGtxsOpTXuKDPSb3ES2UaCV+oT1mb+WPkr38qJmM2QEl1iPsQp7n4xXoyEl1YY2FAMqmDs4/Ilc2+13lZvEGCSraN9FtC6MzSJK6DRYll8RQWINXzV6ldAi2WiV1nBIHvma4dBqKyLoyk0L4b6f3tPph7u5lkOGYIkRxuldGH57FsEfpOkvSV/GFT0esiDTVozf1jo3lJ0hkH0aWb5h6MtPZKDSJyXgunozx3kKc/enUQBtd+iT4V7doYt/Y4mmOoPSMUs8BDpu2L9+mi5aM02yKGjwh/KKa+31/KgAA8nrvXJRpe+qfsrakF5LLfk9/8SqLxZsae26kEghqvWopB0gH/VDLqRFRBRsMljo6H37r/vd5+XlCbq/5YDWDNylIyJK3hB1GeLoX/98xUhnsIYRv+2RodFs7TsdiMplYO0sx8o5Iht0wJguIX+X/Ix0UX+2q4N8EZW0qolGUShUVEYI47mrYs25GDWtLl2Kd58cIvP6LiVbxbooKCEePolBynX9ExbeJHl/2r3Zfw9ak+TPNAyFUGyxJGIYWGTgo+hmEp67eMqWAIqDo56PZoMh4UksoWG4rRQXPhOthx+FAfd/fh2kafwQBwpzfEkTaKe2anFGEZWyFk8Ns2OxUlF+g9M8Ah1oZz2ykpeQuFCz1PYX8Xergmc8kZYFBPwgUZTzGB17+hQwROyiVR7QCWAogsUnzSMmoaJ/eUKN21yXtAcjBfh3uvT0M++9dZUi6TNp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR21MB3098.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(38100700002)(7696005)(76116006)(83380400001)(5660300002)(52536014)(8936002)(55016003)(8990500004)(2906002)(33656002)(38070700005)(6506007)(9686003)(26005)(186003)(64756008)(66476007)(66556008)(66946007)(122000001)(82950400001)(82960400001)(8676002)(71200400001)(508600001)(86362001)(110136005)(10290500003)(54906003)(66446008)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hJT399gKRG5iuXZNwZ9y8MxD9h0VRdlSzoSQU40qAUs0hEvDT/ShQlOLvymJ?=
 =?us-ascii?Q?EF+Trdzz8w4T5s+e2f+LVYfC1dugCONDAqSWZFAan5NoIQw9eKh4Oq8uWtXU?=
 =?us-ascii?Q?1I+Z2XfogEAzDyMfC985A0QSsnefSFy3MdpkL5sIn2sdyrp3tr/q4VaTYZsF?=
 =?us-ascii?Q?WQwUkPdQQ1Jyy1kArtirQXORhMsCM0ItGtQdGJAkNWZUCH5v1jIjFCel+Ylz?=
 =?us-ascii?Q?le0C8tF4eln2Xf4JxMhBCZyqH3njmv9PRXzbeTHWToDO6hfZmzhNi0YxQVwG?=
 =?us-ascii?Q?xVZy8m1HUxSU+AFNJPMjpO64vyrj9CitNI3+o+mkxBRYw00JA293s5+mviRK?=
 =?us-ascii?Q?PkHOa0A8REnBzHVyfk/wLoWfDqJXsJYI8zHfGfSYvdeVXBCgi/at7yPu4WyU?=
 =?us-ascii?Q?06UYBQ8rv9JEPHfdekBfyCK2TkG3NhUBv9wP+Kkz9dJIp8E7lpw4GpT9a5+/?=
 =?us-ascii?Q?xhaXbepf9DxNsYJ+vflDYkYCCkuTZIMzaNNcFLQXvtEl8dpyUgNdwnsjODRf?=
 =?us-ascii?Q?w9LPghQO4k7DRPHwkYGFlQKexYl9pkZen2v0/rWM1yh5ii9GAB4ScfryCDq1?=
 =?us-ascii?Q?8j/dmzlLE6ivjQ6sVgbPIpUjs4jhuyBuHpoZz57hzzwalIF+auHp7Mf/ItMZ?=
 =?us-ascii?Q?6UOm3ZvqChlw4AkH3jKtlfemTykhfjxJRxERyXVb6VFjy+EJFGPrXw5wcoDx?=
 =?us-ascii?Q?4hnTgi75X4CqiTHfOqrAazqYE2gxamr4FmWX3KHVwIGDRjViNVpHf4chPmpO?=
 =?us-ascii?Q?+3mYG191gFDekUgup4Nzi3jbKbIvD1F0iaXbTi78PMxvllCnbtF7Zxeq8KUH?=
 =?us-ascii?Q?lJZVwdhrAFVLAcNrmoLXEmDsb6iJjL3ahKm5yYA/6HB0vOjhKJWULC+0P1Ju?=
 =?us-ascii?Q?/lU1wJwVPAwrC7Bpv0NDJw8i6H7cvNKZz0Ta/nsLoqT+fkD/h8ophsWTon7A?=
 =?us-ascii?Q?ey1N2uRlOn712DcI+gjrWFjBobpZJeU6dq5Ytl6HOWBvx+FtpWYJmbPOuTZA?=
 =?us-ascii?Q?HXmQY8XjVE5l9eZyoujD06XO7/2+ZPLHVo9Lt1vhgu66JhgIRw3Ny/pQCYdv?=
 =?us-ascii?Q?17iC5HEFXonVjFFj5uVU+U90qg1VCdBzfemEEOLZijgEVll+OVqK1nDWMYX2?=
 =?us-ascii?Q?yAY8WfFZ7LmOa9g7oJMfalakMA3LY0WS/ue0M34xuK/hh9nVEKHsr0IqIZZu?=
 =?us-ascii?Q?MiU11n4AeioXtZHu0NmWTy6Yg4MCxzbEHCzzM2b2DwR8F45N4dIDQQ7HpB5N?=
 =?us-ascii?Q?bSxSmnxYdkxTGyKJRdKfH2FM/lvLo1l0f/nxYbCtiffLKkYshZ1JFl9wixfT?=
 =?us-ascii?Q?DfDJGOwgmVlGPJMgVpIMHFKZpxbkouXYWs19kezhsYboLVmXjVL42FQIlVSh?=
 =?us-ascii?Q?ZpZ+bSCR8FCPyHrJQcR2HAoyh/coETTHvdAG2qNhobEB0U3/ils6X3fxzGWO?=
 =?us-ascii?Q?lnYtTi4Pt//PIaRY7+KQxIpASbLeI8BQLMHo4avDQkP0JCkQUi1Zr+Q1KK0U?=
 =?us-ascii?Q?VjxTtwlN54SGWkbtmozKqkKwzfu7UztBsZ7iJz4gL4QmZ17AXm0/qZxfUA7u?=
 =?us-ascii?Q?oezDZW5tMeAtCMIXR5XJnhwXzgp212pUnK2wcdB67uTYGkW8wWBsXLoP+UGx?=
 =?us-ascii?Q?PjdYQWCFdD+Z9fLno4O/RiO5YxDpnYB/1zZ841itwuFjJZ1gk4f1V8TCB9pi?=
 =?us-ascii?Q?j3xW3g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR21MB3098.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f859dd-70ef-4531-b5dc-08d9f6ebf7bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2022 16:45:58.2707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8rYzL59HSx0F01WUtD0+Nl3ES/AME09edQ4aCRJWUQ7tQT+a0uYOBVle3SrMwSnQ89CaSjdFN8XCN6n+/1X/hSuf518FL9YdOSwxeVja+dE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1876
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Boqun Feng <boqun.feng@gmail.com> Sent: Wednesday, February 23, 2022 =
5:16 AM
>=20
> DM_STATUS_REPORT expects the numbers of pages in the unit of 4k pages
> (HV_HYP_PAGE) instead of guest pages, so to make it work when guest page
> sizes are larger than 4k, convert the numbers of guest pages into the
> numbers of HV_HYP_PAGEs.
>=20
> Note that the numbers of guest pages are still used for tracing because
> tracing is internal to the guest kernel.
>=20
> Reported-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  drivers/hv/hv_balloon.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index f2d05bff4245..062156b88a87 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -17,6 +17,7 @@
>  #include <linux/slab.h>
>  #include <linux/kthread.h>
>  #include <linux/completion.h>
> +#include <linux/count_zeros.h>
>  #include <linux/memory_hotplug.h>
>  #include <linux/memory.h>
>  #include <linux/notifier.h>
> @@ -1130,6 +1131,7 @@ static void post_status(struct hv_dynmem_device *dm=
)
>  	struct dm_status status;
>  	unsigned long now =3D jiffies;
>  	unsigned long last_post =3D last_post_time;
> +	unsigned long num_pages_avail, num_pages_committed;
>=20
>  	if (pressure_report_delay > 0) {
>  		--pressure_report_delay;
> @@ -1154,16 +1156,21 @@ static void post_status(struct hv_dynmem_device *=
dm)
>  	 * num_pages_onlined) as committed to the host, otherwise it can try
>  	 * asking us to balloon them out.
>  	 */
> -	status.num_avail =3D si_mem_available();
> -	status.num_committed =3D vm_memory_committed() +
> +	num_pages_avail =3D si_mem_available();
> +	num_pages_committed =3D vm_memory_committed() +
>  		dm->num_pages_ballooned +
>  		(dm->num_pages_added > dm->num_pages_onlined ?
>  		 dm->num_pages_added - dm->num_pages_onlined : 0) +
>  		compute_balloon_floor();
>=20
> -	trace_balloon_status(status.num_avail, status.num_committed,
> +	trace_balloon_status(num_pages_avail, num_pages_committed,
>  			     vm_memory_committed(), dm->num_pages_ballooned,
>  			     dm->num_pages_added, dm->num_pages_onlined);
> +
> +	/* Convert numbers of pages into numbers of HV_HYP_PAGEs. */
> +	status.num_avail =3D num_pages_avail * NR_HV_HYP_PAGES_IN_PAGE;
> +	status.num_committed =3D num_pages_committed * NR_HV_HYP_PAGES_IN_PAGE;
> +
>  	/*
>  	 * If our transaction ID is no longer current, just don't
>  	 * send the status. This can happen if we were interrupted
> --
> 2.35.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

