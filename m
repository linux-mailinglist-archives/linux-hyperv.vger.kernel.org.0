Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEF7601301
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Oct 2022 17:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiJQPxi (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 17 Oct 2022 11:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJQPxh (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 17 Oct 2022 11:53:37 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11021020.outbound.protection.outlook.com [52.101.52.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356AE6AA29;
        Mon, 17 Oct 2022 08:53:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LawCI05jaQvcXDahvio1xkgaNw1/Wo+jAHwkzzMY9uggqaTKm6SSxKwwzsrUNFprIxarWjm+lIOBmiwWWCsZZuBpkAy0ie8XIT8jh/J5i0HVmwT3buVzyNzHlDcEmSf93mcRsTEPH9ZNU8isVXQPcLBkM39GCq0OX/zB4RDNfLg8UC8VSpPyuTNYxL3iQiCytadaSKQzx0EA29e9ewst19eAQqLm6iTrKz9a9iaGFTWXi4O9p2kR9jvQyjJrws5u9OY/0ZtfHe8EzTpB2JwbbyglLCLRZPwudQ2opaujZ8c+/NiAhIh7TKuG4PWHPQbYXr0MgZgeQwOzF4RCR1jThw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ya0I0V64Y1CnfsGg9PaJ9Dk4zBmnRSe1rY5FIiucd1I=;
 b=S8V8r6r5LheqM9exwWkEUhB3CM6qCtBXx0Gt7J2ptfdprMCGFLDk/dYnbrCsq/VmNaAI1FzW3vfn5+z0EWmP0mcArIcim3ehYVWyh2yj/GN3vq0LuE9xZQ81QAilx7cFoj8pd1s4n2QL1Wp/qMZlGADKvYEpN2T7g0YeAO4UPQK3uNvmq0lGJrsfZI9TW23D1vCfiHqH/F3rYWhj0llOZUoMvTXh9tvXldwYTEHOWMAXFvsrZVL9PrZAFlfeLwPkNnj0jZQEmq6usfu0Xap44xjTiZVKZADAxvkzbdWXEEb14xU4+Itl6CU/DAxLlrqw0ETxrdgSv0lEM5+8lNBU1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ya0I0V64Y1CnfsGg9PaJ9Dk4zBmnRSe1rY5FIiucd1I=;
 b=KsmxkfkK0ldznTNb96YqBPMKGFVb35I3ycCm4GMKv+KlFLlai1VSejzuyaHIAMHkxSljlQpj43kUJ9Woez2ZyMwPk6HAALiupgkJ0Hwo2dkq7dbOw9DNUDAr7ubrzHEYdEBbMbKXFKGPMZTGWuYQPLAMi88het22PxhnaIxEJ6k=
Received: from SN6PR2101MB1693.namprd21.prod.outlook.com
 (2603:10b6:805:55::19) by LV2PR21MB3300.namprd21.prod.outlook.com
 (2603:10b6:408:172::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.6; Mon, 17 Oct
 2022 15:53:31 +0000
Received: from SN6PR2101MB1693.namprd21.prod.outlook.com
 ([fe80::af9b:5444:77eb:448d]) by SN6PR2101MB1693.namprd21.prod.outlook.com
 ([fe80::af9b:5444:77eb:448d%7]) with mapi id 15.20.5746.009; Mon, 17 Oct 2022
 15:53:31 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Shradha Gupta <shradhagupta@linux.microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH v2 2/2] hv_balloon: Add support for configurable order
 free page reporting
Thread-Topic: [PATCH v2 2/2] hv_balloon: Add support for configurable order
 free page reporting
Thread-Index: AQHY1JIvAH1tpR6pBUuxtLspSgLE864S1zPw
Date:   Mon, 17 Oct 2022 15:53:31 +0000
Message-ID: <SN6PR2101MB16937E0058C9452AF3EC4B4ED7299@SN6PR2101MB1693.namprd21.prod.outlook.com>
References: <1664447081-14744-1-git-send-email-shradhagupta@linux.microsoft.com>
 <1664517699-1085-1-git-send-email-shradhagupta@linux.microsoft.com>
 <1664517699-1085-3-git-send-email-shradhagupta@linux.microsoft.com>
In-Reply-To: <1664517699-1085-3-git-send-email-shradhagupta@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=82bb6aad-87b6-4d60-a113-1f3fd7e11905;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-10-17T15:50:25Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR2101MB1693:EE_|LV2PR21MB3300:EE_
x-ms-office365-filtering-correlation-id: 067ebaa3-855d-4c0d-a569-08dab057bd73
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sSMKpXVLeM8+gJisi0KhZST87HOQzcdYdB+9g6+sgL9doAhRZdHjaQ4pkeCdJxhIu2UD4tlXQvovSXNifkbMeJWbZ8rpeRMRI9P2EWIk+MrBi3r2szYAFa0w5Mh1W/Vu/EzbfVMK7M7yEULf23x5Vfud9PY8jdxmB+M9XRMNa3SKib0uZiknToJFzQLoLmsT518Y9Ji8euFMYygO62X3F84BR5sc8rFdhMgm/awkkkB4Cdcf+xF/5myhvN3TxEGYIsQDiv5oIov1/YWdpqhEqqllpVnYk5i4wyc9Avr3WLP/e2W0cbMm52V/esLUOBvYObnjYN8FBoSKiKChAzxUPiIttTMX5gKHDq5w8964697lVlLuQpiUoV3nG+xOK39V0HtBJiHQXcajTAItRTSrf7sJb2rDRVGpczw6GQUAafXemxsVclngqzfkAjniDZSjxF5zo/ro9mh8LcALHlpSRTEusP+jPa9p9iU9WqhmkkIiqTj1g0e0GWb1RFB3RQ2gE1NwIAHw6UnNOBv+W5c/K1u0dQr29JPC7WWrVvFYBWUHsobwdhTfnzGgG/6AiM6uIitW3v6lLDnpUJzGv7JC67E1HMQ7MSe7/Ir2Xbn9vWynRP+pf/+dAjMAQwJ47gtgKkeY9HmWpm4yyHuEqdjKsVdiYF0b3Oa1tKy5IEhRm9ycQMqPrBIbWWttSncLMg6C2mSXEWj7gF96sZXL5LxZc0JcXYo31rSt7usEq856rj+d70ygViXtCbrUBC7x8QRkj9ZlyybQwMEGCmMzT5w/+uAQEDMyoUS2SA89pNUZk785bYcU1v6Fkt6LT7MSJtBn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR2101MB1693.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(451199015)(316002)(55016003)(64756008)(82950400001)(110136005)(41300700001)(8990500004)(82960400001)(8936002)(186003)(8676002)(9686003)(2906002)(26005)(107886003)(52536014)(5660300002)(4326008)(38100700002)(76116006)(6506007)(66476007)(54906003)(66946007)(66446008)(7696005)(66556008)(33656002)(122000001)(38070700005)(478600001)(71200400001)(10290500003)(86362001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ipnV79gDa33NMcDUHqISuJTR45jqwrbW5cfFn3Z2EwajNcRhxn3nOzT89MAC?=
 =?us-ascii?Q?sX3TYygEdzLVJZNx2Yqz/a2YFPaihUP9NgYbGYrSTrm8gRfwoAQA/hWQPCLw?=
 =?us-ascii?Q?tDrXPBcAFx1Jc4HgSvGOrY9IUysoKpMpbpMf8IjRd5UBi/QNgpZnf5xtHU+V?=
 =?us-ascii?Q?K9rheUcp/kI4z3HVJ9eaVVzWrXQ54O1CcN4PIMAMa+yJYExwUghIdF+IfY0/?=
 =?us-ascii?Q?MKtHP2VTzjAK1jvk16fvfjR44QbaHqMlLEYVGEUUXxvoa/41KGgUJ2EndLpL?=
 =?us-ascii?Q?PDTw1j4Gde3RNSGDdrU9eANfLGOVpNUeCvsLqawZ9F7GUJt9+w4UbU0zeguB?=
 =?us-ascii?Q?q+vDzzFa/v7oJZDFI2AkLU6HZTut+4z4LGqvbto6SjGzjHiNMi9cQW/Rfnei?=
 =?us-ascii?Q?p9IW8oE/1x+JdprojqMcuS2wJT2wyXrYtfix/cJtMSpj5c1eDD658dqyBUZI?=
 =?us-ascii?Q?EJnRevJGZFQ9A6QUJFF7KtKmejdrMCRyefb9DaBQ/a35rTk0HgZBGg4bnwBD?=
 =?us-ascii?Q?xKpA1AiP+I1JEtTVzwKTzMhBllMEhvYRHQOP5CIjNhBUlch/oWeRFSrDt+ub?=
 =?us-ascii?Q?E6MRZXkr68zwPN/SGPG8l9EIzFZZ2s/P5muGOl1a67kj/Zg/SkDm/p4BCSr2?=
 =?us-ascii?Q?eO8IBjvmW9gS5Bj75vhtRONynwhKgNfg4pWXcI72rF9rNa+zJbQudO8nzctB?=
 =?us-ascii?Q?j4YNlWGjMPaJwJ/IHfQ140mjAb8IMF/CHENgm+28pAqI5t3wN7XyZW0ezfof?=
 =?us-ascii?Q?C/00wnsA4/AKKEyduKXwMptvEW+DYEhAXQT7ryGAu3gR4Upz97D8Whm+QghX?=
 =?us-ascii?Q?OgxUeltKM0MV+b/O+EgG0tnoIeqt0Nt3gT3WEaJN+7DB4V5K3vkzruOdOyJ0?=
 =?us-ascii?Q?VKPaQaeTiUeab3E1cXoRk/3FdXl59rcKWDYphHrOt7NPNetdpU1/PLWfO+Bu?=
 =?us-ascii?Q?OF841kEVx2UvhThl5hi55tB1l54LlFND6che/itvDCvbVvjf75qnv5odbtYN?=
 =?us-ascii?Q?Ka/2D6MoRHIWmC2k72aTJfRQP6uHKA2m63JLGrD6a2caCRLTbS6P7t2XmZhF?=
 =?us-ascii?Q?4x+lQaTYQamR6IvOzJw3HEtNQg7xD2e8lCi7hrFuDmNVwFAqbG0STR56YywT?=
 =?us-ascii?Q?Pf3Nt44tWq+OdFEvvvqS3sz3dvdLiNiDPPiX1JFQBCd0y954dU05YowexMqS?=
 =?us-ascii?Q?DE/Eo4FoVeHE026P5UgDPArRmIX2NP48pJIvypNQw4LYaP7Piap2EuHovVBN?=
 =?us-ascii?Q?nWKwJfxBwnzxOuGoUIWcqkRREVDRFdBP7/pwV45pw9DfL/ZRj4QL1Ioxap+Z?=
 =?us-ascii?Q?Jt7Pv8YJp6I6KyhtVvpcW8bdVpHYkJWWd/D7xF8Q0vtnqJBJAZGQF/QvRptS?=
 =?us-ascii?Q?Ey3yIA121ehcRha2cNLGckAUuJMWph6wANc1xTEdG2J6nD1Thmq3nfMVtvX5?=
 =?us-ascii?Q?0zMwYZLnmuY29wEDj09G3lcN2CgVkd09KCDDPy4OkuW+K0IAjKJW/ZiJ5ELw?=
 =?us-ascii?Q?WEP+vXu0BcyJcVwW4jsKPvm+1/jdjeI4jbc0SAUJssc7LM/d2M8cd35VDAoi?=
 =?us-ascii?Q?rh8UhZyIVKMu5Q6dSmI+YXmBQRogry/LxElbS4G6V6a7Dk3VnnKD6nlx/M2K?=
 =?us-ascii?Q?xA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR2101MB1693.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 067ebaa3-855d-4c0d-a569-08dab057bd73
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2022 15:53:31.2993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xwpGj/o9zBSIuxC7vrGZWG3FMMP8U5mozcBsXXXRsPCqXquwb+WLrjP3N/xWu15u4xQiWxhMZTUO1tagSHtk03B9kc07f5qFLGagk3QyTWo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR21MB3300
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Shradha Gupta <shradhagupta@linux.microsoft.com> Sent: Thursday, Sept=
ember 29, 2022 11:02 PM
>=20
> Newer versions of Hyper-V allow reporting unused guest pages in chunks
> smaller than 2 Mbytes.  Using smaller chunks allows reporting more
> unused guest pages, but with increased overhead in the finding the
> small chunks.  To make this tradeoff configurable, use the existing
> page_reporting_order module parameter to control the reporting order.
> Drop and refine checks that restricted the minimun page reporting order
> to 2Mbytes size pages. Add appropriate checks to make sure the
> underlying Hyper-V versions support cold discard hints of any order
> (and not just starting from 9)
>=20
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> ---
>  drivers/hv/hv_balloon.c | 94 ++++++++++++++++++++++++++++++++---------
>  1 file changed, 73 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index fdf6decacf06..7088ed056e50 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -469,12 +469,16 @@ static bool do_hot_add;
>   * the specified number of seconds.
>   */
>  static uint pressure_report_delay =3D 45;
> +extern unsigned int page_reporting_order;
> +#define HV_MAX_FAILURES	2
>=20
>  /*
>   * The last time we posted a pressure report to host.
>   */
>  static unsigned long last_post_time;
>=20
> +static int hv_hypercall_multi_failure;
> +
>  module_param(hot_add, bool, (S_IRUGO | S_IWUSR));
>  MODULE_PARM_DESC(hot_add, "If set attempt memory hot_add");
>=20
> @@ -579,6 +583,10 @@ static struct hv_dynmem_device dm_device;
>=20
>  static void post_status(struct hv_dynmem_device *dm);
>=20
> +static void enable_page_reporting(void);
> +
> +static void disable_page_reporting(void);
> +
>  #ifdef CONFIG_MEMORY_HOTPLUG
>  static inline bool has_pfn_is_backed(struct hv_hotadd_state *has,
>  				     unsigned long pfn)
> @@ -1418,6 +1426,18 @@ static int dm_thread_func(void *dm_dev)
>  		 */
>  		reinit_completion(&dm_device.config_event);
>  		post_status(dm);
> +		/*
> +		 * disable free page reporting if multiple hypercall
> +		 * failure flag set. It is not done in the page_reporting
> +		 * callback context as that causes a deadlock between
> +		 * page_reporting_process() and page_reporting_unregister()
> +		 */
> +		if (hv_hypercall_multi_failure >=3D HV_MAX_FAILURES) {
> +			pr_err("Multiple failures in cold memory discard hypercall, disabling=
 page reporting\n");
> +			disable_page_reporting();
> +			/* Reset the flag after disabling reporting */
> +			hv_hypercall_multi_failure =3D 0;
> +		}
>  	}
>=20
>  	return 0;
> @@ -1593,20 +1613,20 @@ static void balloon_onchannelcallback(void *conte=
xt)
>=20
>  }
>=20
> -/* Hyper-V only supports reporting 2MB pages or higher */
> -#define HV_MIN_PAGE_REPORTING_ORDER	9
> -#define HV_MIN_PAGE_REPORTING_LEN (HV_HYP_PAGE_SIZE <<
> HV_MIN_PAGE_REPORTING_ORDER)
> +#define HV_LARGE_REPORTING_ORDER	9
> +#define HV_LARGE_REPORTING_LEN (HV_HYP_PAGE_SIZE << \
> +		HV_LARGE_REPORTING_ORDER)
>  static int hv_free_page_report(struct page_reporting_dev_info *pr_dev_in=
fo,
>  		    struct scatterlist *sgl, unsigned int nents)
>  {
>  	unsigned long flags;
>  	struct hv_memory_hint *hint;
> -	int i;
> +	int i, order;
>  	u64 status;
>  	struct scatterlist *sg;
>=20
>  	WARN_ON_ONCE(nents > HV_MEMORY_HINT_MAX_GPA_PAGE_RANGES);
> -	WARN_ON_ONCE(sgl->length < HV_MIN_PAGE_REPORTING_LEN);
> +	WARN_ON_ONCE(sgl->length < (HV_HYP_PAGE_SIZE << page_reporting_order));
>  	local_irq_save(flags);
>  	hint =3D *(struct hv_memory_hint **)this_cpu_ptr(hyperv_pcpu_input_arg)=
;
>  	if (!hint) {
> @@ -1621,21 +1641,53 @@ static int hv_free_page_report(struct page_report=
ing_dev_info *pr_dev_info,
>=20
>  		range =3D &hint->ranges[i];
>  		range->address_space =3D 0;
> -		/* page reporting only reports 2MB pages or higher */
> -		range->page.largepage =3D 1;
> -		range->page.additional_pages =3D
> -			(sg->length / HV_MIN_PAGE_REPORTING_LEN) - 1;
> -		range->page_size =3D HV_GPA_PAGE_RANGE_PAGE_SIZE_2MB;
> -		range->base_large_pfn =3D
> -			page_to_hvpfn(sg_page(sg)) >> HV_MIN_PAGE_REPORTING_ORDER;
> +		order =3D get_order(sg->length);
> +		/*
> +		 * Hyper-V expects the additional_pages field in the units
> +		 * of one of these 3 sizes, 4Kbytes, 2Mbytes or 1Gbytes.
> +		 * This is dictated by the values of the fields page.largesize
> +		 * and page_size.
> +		 * This code however, only uses 4Kbytes and 2Mbytes units
> +		 * and not 1Gbytes unit.
> +		 */
> +
> +		/* page reporting for pages 2MB or higher */
> +		if (order >=3D HV_LARGE_REPORTING_ORDER ) {
> +			range->page.largepage =3D 1;
> +			range->page_size =3D HV_GPA_PAGE_RANGE_PAGE_SIZE_2MB;
> +			range->base_large_pfn =3D page_to_hvpfn(
> +					sg_page(sg)) >> HV_LARGE_REPORTING_ORDER;
> +			range->page.additional_pages =3D
> +				(sg->length / HV_LARGE_REPORTING_LEN) - 1;
> +		} else {
> +			/* Page reporting for pages below 2MB */
> +			range->page.basepfn =3D page_to_hvpfn(sg_page(sg));
> +			range->page.largepage =3D false;
> +			range->page.additional_pages =3D
> +				(sg->length / HV_HYP_PAGE_SIZE) - 1;
> +		}
> +
>  	}
>=20
>  	status =3D hv_do_rep_hypercall(HV_EXT_CALL_MEMORY_HEAT_HINT, nents, 0,
>  				     hint, NULL);
>  	local_irq_restore(flags);
> -	if ((status & HV_HYPERCALL_RESULT_MASK) !=3D HV_STATUS_SUCCESS) {
> +	if (!hv_result_success(status)) {
> +
>  		pr_err("Cold memory discard hypercall failed with status %llx\n",
> -			status);
> +				status);
> +		if (hv_hypercall_multi_failure > 0)
> +			hv_hypercall_multi_failure++;
> +
> +		if (hv_result(status) =3D=3D HV_STATUS_INVALID_PARAMETER) {
> +			pr_err("Underlying Hyper-V does not support order less than 9. Hyperc=
all failed\n");
> +			pr_err("Defaulting to page_reporting_order %d\n",
> +					pageblock_order);
> +			page_reporting_order =3D pageblock_order;
> +			hv_hypercall_multi_failure++;
> +			return -EINVAL;
> +		}
> +
>  		return -EINVAL;
>  	}
>=20
> @@ -1646,12 +1698,6 @@ static void enable_page_reporting(void)
>  {
>  	int ret;
>=20
> -	/* Essentially, validating 'PAGE_REPORTING_MIN_ORDER' is big enough. */
> -	if (pageblock_order < HV_MIN_PAGE_REPORTING_ORDER) {
> -		pr_debug("Cold memory discard is only supported on 2MB pages and above=
\n");
> -		return;
> -	}
> -
>  	if (!hv_query_ext_cap(HV_EXT_CAPABILITY_MEMORY_COLD_DISCARD_HINT)) {
>  		pr_debug("Cold memory discard hint not supported by Hyper-V\n");
>  		return;
> @@ -1659,12 +1705,18 @@ static void enable_page_reporting(void)
>=20
>  	BUILD_BUG_ON(PAGE_REPORTING_CAPACITY > HV_MEMORY_HINT_MAX_GPA_PAGE_RANG=
ES);
>  	dm_device.pr_dev_info.report =3D hv_free_page_report;
> +	/*
> +	 * We let the page_reporting_order parameter decide the order
> +	 * in the page_reporting code
> +	 */
> +	dm_device.pr_dev_info.order =3D 0;
>  	ret =3D page_reporting_register(&dm_device.pr_dev_info);
>  	if (ret < 0) {
>  		dm_device.pr_dev_info.report =3D NULL;
>  		pr_err("Failed to enable cold memory discard: %d\n", ret);
>  	} else {
> -		pr_info("Cold memory discard hint enabled\n");
> +		pr_info("Cold memory discard hint enabled with order %d\n",
> +				page_reporting_order);
>  	}
>  }
>=20
> --
> 2.37.2

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

