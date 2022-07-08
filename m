Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD2056BD5C
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Jul 2022 18:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238494AbiGHPjR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 8 Jul 2022 11:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237719AbiGHPjR (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 8 Jul 2022 11:39:17 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2135.outbound.protection.outlook.com [40.107.94.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A201D1FCF8;
        Fri,  8 Jul 2022 08:39:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9e/Wi1G7q9ePOrWyIrxNJA/J6LvGwF5iCWolcDm2RbAzYR/1GU4Y0RwetTB/b5LibE8KaWhRvglWJzvR45QEhFnIbAdJZ0WCo6pMj4Mym6QSL2B5NvbPwX5gT7h17VoaTTS58UEK4S6AIqEfa8dgoVKeloxFdYMXaEhF/DeXZqTzuiZVskGEIk2fo4KSrkpSBjdmV/xSmV2lsGbaLcRSvbm9q6eOINhNLBgbvUSm1h+Cz2h8yWs64R/d7h1hSa8y9Wue6sgbzNpSqiYQ14688yFa1MoIwUCAk4cmzj+tujgErTP4WKrE22tNLLHCPuOwuk7KK84ZR98+PqhVWlY/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VddDCrWKDik8XsXfPk0x+hat6VJSvxsrtnMksmpiykA=;
 b=bKxDYZWs/47v8FaQ4QS62YvpuRtRlTzbfLj0sJg+cgNGPtxwQ3B7s/JnbHZUDZ9UJcWhSRgXtVd8JjF1CAEhzBGt+25Qn3n5G8ddZRf+2XvvZiGcb/XCUfwUYLaGR7fPQbFdXdfcnlrL+iQOjSMpt/5lL/4C9a5olHaLho5iV6zauRm2U6i5G6S6btRDr0EKa0DJ9dunD45papDJuv//xoug4BHS49V6c2RwLA5SFkoP6RfrrcvwnpDQwsCUtKvXdKEp/8qvcILYswxb9rbmYtk3i77Ouvpb/VmtWPefjGxXsUCx38GkC3bfjIp6WKZXZ7wfQrEYrtMEDGfu4AZFbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VddDCrWKDik8XsXfPk0x+hat6VJSvxsrtnMksmpiykA=;
 b=WvKAora0+ouehO4oM/zUJnij+mpbt9mTiNgR3yF5jtLUSejA4GAeWI9r++Y5395u0SA4LE5la8go7zZ/t5v2BFBC8TvCGOfMROKZYmcsHB+E3mbCRLX+UvZUdZeX/oEh4rIYXJLVUTFpe74L8IAeUIunQG/anU8ZTwKcvu4cxVQ=
Received: from BY3PR21MB3033.namprd21.prod.outlook.com (2603:10b6:a03:3b3::5)
 by BY5PR21MB1395.namprd21.prod.outlook.com (2603:10b6:a03:238::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.7; Fri, 8 Jul
 2022 15:39:10 +0000
Received: from BY3PR21MB3033.namprd21.prod.outlook.com
 ([fe80::e929:ba8f:531a:3cb1]) by BY3PR21MB3033.namprd21.prod.outlook.com
 ([fe80::e929:ba8f:531a:3cb1%4]) with mapi id 15.20.5417.011; Fri, 8 Jul 2022
 15:39:10 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
CC:     "kernel@openvz.org" <kernel@openvz.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/1] Create debugfs file with hyper-v balloon usage
 information
Thread-Topic: [PATCH v2 1/1] Create debugfs file with hyper-v balloon usage
 information
Thread-Index: AQHYkWRzd2IDnJc9mk2uH7VBWzztDK10nYeQ
Date:   Fri, 8 Jul 2022 15:39:10 +0000
Message-ID: <BY3PR21MB3033BA045EA7EF6A5965438AD7829@BY3PR21MB3033.namprd21.prod.outlook.com>
References: <20220706180202.bzbm6boi232bruct@liuwe-devbox-debian-v2>
 <20220706181510.32236-1-alexander.atanasov@virtuozzo.com>
In-Reply-To: <20220706181510.32236-1-alexander.atanasov@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ac801d37-a63b-473c-82c2-b376ba381050;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-07-08T15:34:05Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a0a4b225-633b-476c-3e8a-08da60f8007c
x-ms-traffictypediagnostic: BY5PR21MB1395:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W1SgHW69nLfnTZOszyf3LEoxE5mcWqvRDPW0iUYOp734kT45i5id81lF9KOag+FIsQ1ETfg837GzRtBpgP3GSL44K3R0jmWokeQxGtrFMNqdCPHoGgWNh3FA15sWtcEkBQxrzBI2VkLta9BeKuKbcT+N/CPdhxXdu1O2sAwGfMfMmO2NS4LMpzTUK6Or2LH+uONqyRVgtk4nKQBlMs7+1EM9HyJorXe888aC+VtRj18KvrLVErcABph6cFOjzf5R9+ZC6fSXqpzE3gUmXVC8og0idPmtV5uqjeSPwKrh9FMHtr8Fey8YQhXmak3rhHXjcw2+8UQVOsMxdfA3Q0zFDXZBBtVT+XHvVnmZRml6VkcpS6g/96Oqb3AC+UFKFRQwMCm3FY6RzHyaEkxDz4AUnQN1Me57UaXffFvBHrh2nSnQ/AIdrln6hCd6VGq7pY7eyILO8N5eLCymxDw+9jnsXhKnf2ukRIjma3842rHBtO/jvyGkp75p6yZLai0HQTvp4Wm9ODBgB80yjS10wP60/mXUd6cWN9PpqgErZdwP3cS6/rf2hB4GdDo3J7yVgS5O/tpYZmwKTTbMffMMKmvL+DFsNuDKV6+OzSwhPVZPcKtnNA0vsDVjwwSDKK1O3Ll8inDIlHB7dSQBGSNmbXA99g4/9zulzl+HCdwieDZsSPVhCxxLFzCaX9HVfeg5j5C7cc3nSAZPr/cEpzioissiwSDzmDFrrs43y7y5YY9NZ2FXjlNlm7gqb9utCLJYaCdd/z0rO4KrsiaUEDMlnyUlFpWt/hrGozPLZ/BUJWW4t0n6pddgFSc8zE6yp7jWLXNxlYCUsEM+rF+bjstbHUvx83Gt/XajWszqYbFY5Q8GuGaH80ORz3iuz3e3j6yd+CHc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR21MB3033.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(39860400002)(136003)(376002)(396003)(451199009)(33656002)(41300700001)(110136005)(2906002)(82960400001)(86362001)(38070700005)(38100700002)(8936002)(52536014)(316002)(82950400001)(478600001)(5660300002)(10290500003)(6636002)(122000001)(66476007)(66946007)(64756008)(66556008)(76116006)(4326008)(8676002)(55016003)(186003)(66446008)(71200400001)(26005)(54906003)(7696005)(9686003)(83380400001)(8990500004)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rG9NM/2arXedOBf4JdVAQrVmEiG5QfkMeckOPMiM5l3tHdcTA6O8DAOsEPgT?=
 =?us-ascii?Q?5BcPgVFw3eTyoA5YVux2cWkmbr1Rtiyg+ZYRBqUjnjn2p/H7cUAXS2E8sGLt?=
 =?us-ascii?Q?DJeYZcn8Fe5fbp0wxMMX8KKtBkhU7ks01dkkWvUpDSbkftFKB+u7q6WK9/wX?=
 =?us-ascii?Q?K8sHwYEsPswb/zwcuFXfc/n/I6OUlxggFnd6vI8f0NUQhTyOo1EjjG9c89UJ?=
 =?us-ascii?Q?M7H8q+7zRPWZJgC6Sto7J65dNuvxk53YutC/kmN7Szc8EMoh76mBTo0O5brl?=
 =?us-ascii?Q?DgQbLGkEknLHA49z/2p23FYcb5LvyBUqJcaAd2U1TaurepZm8sp0bQUag3HO?=
 =?us-ascii?Q?wPToZgRlutxfo61o4bT1kEWGZDXDAjjVImOO1fS3qZ0V7XPdzt01ey8jyZ8G?=
 =?us-ascii?Q?33xRIA4nO42BZHbA/J53+JmSBsl4JvEbDS23xxC72Zngki5AAFzjboCvMHLG?=
 =?us-ascii?Q?ca68e6gum50yf+Umt8r37R+LHp/lfgzb9YoTSWgeiyTK8IKiaj7NldsX2VxJ?=
 =?us-ascii?Q?VzwNDYxBYhFpzAqcfzHvPwO4BvQyGkVxnZydjZbODTaKYRwhD6/UWiTE+ic5?=
 =?us-ascii?Q?GM9WHCb07CHmo3trnhMlm3R7A0tc9djuHB3L4B9yQRyEbJvV/dQKGIZSj60d?=
 =?us-ascii?Q?lJTycoYBLklhzcYvUX1MW8Br+k8kA8T2bBDlLyWEz5M801B2NxmS+zcVRnx4?=
 =?us-ascii?Q?NaMDpUXiKduwtzZULs9n4Sxmk0meYqf1if0nZrIIGLo7KBffhNvKVjzhi4Cm?=
 =?us-ascii?Q?cajJwNn2XbmTN3OIYnt/XsqY2IZQTCpISrVr3+hAa9ur+49xUyKmpm83Xv94?=
 =?us-ascii?Q?4OeUPgTTaFtcSDqqHQp3VqCEAaY4e2EUMg5rLz2r9JJsjDth1nF87Dajzg+F?=
 =?us-ascii?Q?DPCqWSYPkKiOdEB4VRm2jEDQaaq4FeoPhFbh/mXICRINVUGTXjOFW94Nh2kz?=
 =?us-ascii?Q?2UpNEK0reGOhKroM2oakKp/TaABy3e2yvlAHeZ1rtv+Kh6hRLmn2IM2D9zGB?=
 =?us-ascii?Q?yPui+XKYaB84CNxdnseAnKm++VPw/mhOdN888twS7f8TlTrumPBlXkLzzsJv?=
 =?us-ascii?Q?VTbEKUxhkHg+PMC9ATnsIxPVaw/sR12BqGMh1ubNe8lhVqitSt3SdiVDCHrT?=
 =?us-ascii?Q?km86gCmLlsk3YCPbK0CwV0oDZEByc4CjmnK57m8dmQH9JhsYMZPPIajc4Mqd?=
 =?us-ascii?Q?EXnbog/s7hD/C+W68IYQLOEzaFKyZ35rwdTKI9JjB7AceyC8aQ6kPpaIQiZK?=
 =?us-ascii?Q?VA6VIXWXLqnSUSMg0YtB+M4P5sCuijA2Ahm2hPFZ72FTwgqvVZpUUJy/Cz+X?=
 =?us-ascii?Q?16TFMooH3BR5sbYCTNO78dQePTanjbQH1SrTFkoTZjejdCN/6137qEGiohZs?=
 =?us-ascii?Q?xZnfGbjy5QWB92dMJ1XbqiHfX0F8ZHJ84nR3MUYk1jbT/OrwICtbrKtjBAyy?=
 =?us-ascii?Q?Y01L1A1L1lLrVEjxC3ETf5c0bid7Jj3XfxO7jsGXbrQozjFQfiE+a+FkNjq5?=
 =?us-ascii?Q?AnmPe/m60RZS/kK757sDGBt6tXCOHVxGeEB1gdYwHUoF8o6sn3045TVSNXRZ?=
 =?us-ascii?Q?0X5Cp2z3fcZHIbGGRYUJ/sa8fT49Vmww3k1aGc7CuvGlIOTHn2hg2JXRTwyc?=
 =?us-ascii?Q?Mw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR21MB3033.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a4b225-633b-476c-3e8a-08da60f8007c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 15:39:10.2019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VSiyUM9u4tcD9EBAFD/4n14L5pIHq/J7R8qKcpyPYMarEpuH/43zglb2YSYN2BIuN1sgQBrWQySLuNmx0wFVWvPBcBe1zEghw93HHlgVNH8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR21MB1395
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Alexander Atanasov <alexander.atanasov@virtuozzo.com> Sent: Wednesday=
, July 6, 2022 11:15 AM
>=20
> Allow the guest to know how much it is ballooned by the host.
> It is useful when debugging out of memory conditions.
>=20
> When host gets back memory from the guest it is accounted
> as used memory in the guest but the guest have no way to know
> how much it is actually ballooned.
>=20
> Expose current state, flags and max possible memory to the guest.
> While at it - fix a 10+ years old typo.
>=20
> Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
> ---
>  drivers/hv/hv_balloon.c | 126 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 125 insertions(+), 1 deletion(-)
>=20
> V1->V2:
>  - Fix C&P errors - you got me :)

Did you see my code comments on v1 of your patch (in addition to my
broader comment about debugfs vs. tracing) ?  I didn't see a response from
you, and my code suggestions are not incorporated into this v2, so I wonder=
ed
if you disagreed with my suggestions, or just missed them.

Michael

>=20
> Note - no attempt to handle guest vs host page size difference
> is made - see ballooning_enabled.
> Basicly if balloon page size !=3D guest page size balloon is off.
>=20
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index 91e8a72eee14..91dfde06c6fb 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -11,6 +11,7 @@
>  #include <linux/kernel.h>
>  #include <linux/jiffies.h>
>  #include <linux/mman.h>
> +#include <linux/debugfs.h>
>  #include <linux/delay.h>
>  #include <linux/init.h>
>  #include <linux/module.h>
> @@ -248,7 +249,7 @@ struct dm_capabilities_resp_msg {
>   * num_committed: Committed memory in pages.
>   * page_file_size: The accumulated size of all page files
>   *                in the system in pages.
> - * zero_free: The nunber of zero and free pages.
> + * zero_free: The number of zero and free pages.
>   * page_file_writes: The writes to the page file in pages.
>   * io_diff: An indicator of file cache efficiency or page file activity,
>   *         calculated as File Cache Page Fault Count - Page Read Count.
> @@ -567,6 +568,13 @@ struct hv_dynmem_device {
>         __u32 version;
>=20
>         struct page_reporting_dev_info pr_dev_info;
> +
> +#ifdef CONFIG_DEBUG_FS
> +       /*
> +        * Maximum number of pages that can be hot_add-ed
> +        */
> +       __u64 max_dynamic_page_count;
> +#endif
>  };
>=20
>  static struct hv_dynmem_device dm_device;
> @@ -1078,6 +1086,9 @@ static void process_info(struct hv_dynmem_device *d=
m,
> struct dm_info_msg *msg)
>=20
>                         pr_info("Max. dynamic memory size: %llu MB\n",
>                                 (*max_page_count) >> (20 - HV_HYP_PAGE_SH=
IFT));
> +#ifdef CONFIG_DEBUG_FS
> +                       dm->max_dynamic_page_count =3D *max_page_count;
> +#endif
>                 }
>=20
>                 break;
> @@ -1807,6 +1818,115 @@ static int balloon_connect_vsp(struct hv_device *=
dev)
>         return ret;
>  }
>=20
> +/*
> + * DEBUGFS Interface
> + */
> +#ifdef CONFIG_DEBUG_FS
> +
> +/**
> + * hv_balloon_debug_show - shows statistics of balloon operations.
> + * @f: pointer to the &struct seq_file.
> + * @offset: ignored.
> + *
> + * Provides the statistics that can be accessed in hv-balloon in the deb=
ugfs.
> + *
> + * Return: zero on success or an error code.
> + */
> +static int hv_balloon_debug_show(struct seq_file *f, void *offset)
> +{
> +       struct hv_dynmem_device *dm =3D f->private;
> +       unsigned long num_pages_committed;
> +       char *sname;
> +
> +       seq_printf(f, "%-22s: %u.%u\n", "host_version",
> +                               DYNMEM_MAJOR_VERSION(dm->version),
> +                               DYNMEM_MINOR_VERSION(dm->version));
> +
> +       seq_printf(f, "%-22s:", "capabilities");
> +       if (ballooning_enabled())
> +               seq_puts(f, " enabled");
> +
> +       if (hot_add_enabled())
> +               seq_puts(f, " hot_add");
> +
> +       seq_puts(f, "\n");
> +
> +       seq_printf(f, "%-22s: %u", "state", dm->state);
> +       switch (dm->state) {
> +       case DM_INITIALIZING:
> +                       sname =3D "Initializing";
> +                       break;
> +       case DM_INITIALIZED:
> +                       sname =3D "Initialized";
> +                       break;
> +       case DM_BALLOON_UP:
> +                       sname =3D "Balloon Up";
> +                       break;
> +       case DM_BALLOON_DOWN:
> +                       sname =3D "Balloon Down";
> +                       break;
> +       case DM_HOT_ADD:
> +                       sname =3D "Hot Add";
> +                       break;
> +       case DM_INIT_ERROR:
> +                       sname =3D "Error";
> +                       break;
> +       default:
> +                       sname =3D "Unknown";
> +       }
> +       seq_printf(f, " (%s)\n", sname);
> +
> +       /* HV Page Size */
> +       seq_printf(f, "%-22s: %ld\n", "page_size", HV_HYP_PAGE_SIZE);
> +
> +       /* Pages added with hot_add */
> +       seq_printf(f, "%-22s: %u\n", "pages_added", dm->num_pages_added);
> +
> +       /* pages that are "onlined"/used from pages_added */
> +       seq_printf(f, "%-22s: %u\n", "pages_onlined", dm->num_pages_onlin=
ed);
> +
> +       /* pages we have given back to host */
> +       seq_printf(f, "%-22s: %u\n", "pages_ballooned", dm->num_pages_bal=
looned);
> +
> +       num_pages_committed =3D vm_memory_committed();
> +       num_pages_committed +=3D dm->num_pages_ballooned +
> +                               (dm->num_pages_added > dm->num_pages_onli=
ned ?
> +                               dm->num_pages_added - dm->num_pages_onlin=
ed : 0) +
> +                               compute_balloon_floor();
> +       seq_printf(f, "%-22s: %lu\n", "total_pages_commited",
> +                               num_pages_committed);
> +
> +       seq_printf(f, "%-22s: %llu\n", "max_dynamic_page_count",
> +                               dm->max_dynamic_page_count);
> +
> +       return 0;
> +}
> +
> +DEFINE_SHOW_ATTRIBUTE(hv_balloon_debug);
> +
> +static void  hv_balloon_debugfs_init(struct hv_dynmem_device *b)
> +{
> +       debugfs_create_file("hv-balloon", 0444, NULL, b,
> +                       &hv_balloon_debug_fops);
> +}
> +
> +static void  hv_balloon_debugfs_exit(struct hv_dynmem_device *b)
> +{
> +       debugfs_remove(debugfs_lookup("hv-balloon", NULL));
> +}
> +
> +#else
> +
> +static inline void hv_balloon_debugfs_init(struct hv_dynmem_device  *b)
> +{
> +}
> +
> +static inline void hv_balloon_debugfs_exit(struct hv_dynmem_device *b)
> +{
> +}
> +
> +#endif /* CONFIG_DEBUG_FS */
> +
>  static int balloon_probe(struct hv_device *dev,
>                          const struct hv_vmbus_device_id *dev_id)
>  {
> @@ -1854,6 +1974,8 @@ static int balloon_probe(struct hv_device *dev,
>                 goto probe_error;
>         }
>=20
> +       hv_balloon_debugfs_init(&dm_device);
> +
>         return 0;
>=20
>  probe_error:
> @@ -1879,6 +2001,8 @@ static int balloon_remove(struct hv_device *dev)
>         if (dm->num_pages_ballooned !=3D 0)
>                 pr_warn("Ballooned pages: %d\n", dm->num_pages_ballooned)=
;
>=20
> +       hv_balloon_debugfs_exit(dm);
> +
>         cancel_work_sync(&dm->balloon_wrk.wrk);
>         cancel_work_sync(&dm->ha_wrk.wrk);
>=20
> --
> 2.25.1

