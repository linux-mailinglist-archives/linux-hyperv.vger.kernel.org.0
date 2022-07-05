Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824ED56755B
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Jul 2022 19:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiGERML (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 5 Jul 2022 13:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiGERMK (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 5 Jul 2022 13:12:10 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-cusazon11020015.outbound.protection.outlook.com [52.101.61.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3CB1C10B;
        Tue,  5 Jul 2022 10:12:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSh6wnxVCOv9zSqaKZgDOpard5+s4HeH5HA0hjij95ayexX1wV3UHDN6q4xgmC3ydjkSJO+s1arJVATue+Ep+jY7ImizBhUvw6pFNE6IAJsq2yI/2F5ujH7r4QhxgPX2grTq+cQIS8V/K4SrY/1nGWBArmE/C7i67+H4tSiu47ISrsmjMDxwxOQEq6cFixfjjtDRE2nPmy7n79ZsM34QvkodjenFPRwZEsYKMOdl+H17UtS8oEqJ4P+dZ+WJBYX8Tqc4KNn+WgtWkSlSuoLxkT+D6g+gLkHgkGeu/dE2Jlzq/8xoNG8F2PSJpbu0Xb9EHxrxTg1RzXH/ivKjEixQ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0j/aI3M9cMbLkMqGuY5o9ECOY49cs1ORsA9B2BPe/Y=;
 b=P0l2bBuPYjERx2aXU8X8HIwufguD7z+TO4VTT2Bs81Dhs9TKdTT491Jpc9ob6RBf65TKa3WwCl9wDLliu19sp3KVBjYRA5rorM0HK1cR3PrAEDVhmhIDTwjNBuarvSmDkwRlVVa3Gw4OBdOvqduyd+Fa2BUdO1SizkLCOBAX85iX81byos4YULcRred9GQ+cmhoo1Tw2KmHPMF6LUNFKYu8E+3/jBKBVmjvk5C4dOXVqJcWEPMt8KkgdFW08jCCn9g3oHhoThd2qweRrMNzgxwGKeMnPTjfVpWe1a262SgVvjj2c6RzcxYemBiJiZ5KUUEIk9D5C/BQ70nEmKQDK8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0j/aI3M9cMbLkMqGuY5o9ECOY49cs1ORsA9B2BPe/Y=;
 b=G5rYu9s8/34F70XCHfCHPn/iTn75DBtfgnN72qbC8+0/TmTULDPKOs1ibehTZ4j825Tw4N9aUaKLyAnGKKWyGZvHxb3BHX/GjkTzbMeXiRVvvVL+J/LZlHBTfLsWbucE03IVcn4okLeGIIoie1/cv5amQ6pdHqVS6E4ZMH8lam0=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by PH0PR21MB2032.namprd21.prod.outlook.com (2603:10b6:510:ab::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.3; Tue, 5 Jul
 2022 17:12:06 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::7838:dcbf:513b:d992]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::7838:dcbf:513b:d992%5]) with mapi id 15.20.5438.000; Tue, 5 Jul 2022
 17:12:06 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
CC:     "kernel@openvz.org" <kernel@openvz.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 1/1] Create debugfs file with hyper-v balloon usage
 information
Thread-Topic: [PATCH v1 1/1] Create debugfs file with hyper-v balloon usage
 information
Thread-Index: AQHYkFPjkCuXQLzrk0e1tGrJEf8Bx61v/Vow
Date:   Tue, 5 Jul 2022 17:12:06 +0000
Message-ID: <PH0PR21MB3025D1111824156FB6B9D0DCD7819@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <20220705094410.30050-1-alexander.atanasov@virtuozzo.com>
In-Reply-To: <20220705094410.30050-1-alexander.atanasov@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=40a85c4d-835b-4946-b1df-f28bfa72dd31;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-07-05T16:48:08Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f042ad28-025f-4b29-02df-08da5ea97cbe
x-ms-traffictypediagnostic: PH0PR21MB2032:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vMz+QgyP0VGutVPCECo+lVhCpyLmBCZzVTIZhhMSElI6vsIB3OaE7lO03pCgbRvkaG1MkK7do3pdfuq0r6WwdNIi2b7IvHPJQEebyaq0qPaoKG21RkaxoNQFT5qZjkz/Nj7Ai73qFMnQNwPtUtHlKE3FjmIA2DxFLsDRKSx7hMAjOwv/yuPy5EtrW1HouAIxPYuVGabQ0bs1zboId15cGivCkiOKUDwuqnRSEuQbgf4ZLBlboakBUDEnjKABxg8FOZMLvtlxHxvAkyBEX73uoF3HUX2X9obmlZymY2JwHecR9FRMy984h1bf+mDPNHrDqGHN2vy7kYuXOrKCJpdkSIxSIoK2bBvXMKRsAEPIp6VwDaWduW08MrXFB9yfGAiBPbx86VEpcbYQ5Ls8hOpRgAldvA9SfeWYJZ+2WL0dDGN/CPHo12p7mJz0QKOiX5cxEZCi2xs54CD+pX/YDV5MZcWoGu/7Vfmjmq5+IypULXKX1lYegvOt2oW6/N/XYzHXnFKqfmqqkjtmE7eqbhfjz5vgfZlMtm9Ect6xIXccWefvsrY4SZgdyJCkGwcucL9F0p31CqCpqclglOqgS9G1nB6UbytayjaEx6WPrHf11raknj615d3SgV/UtbXKA7zHDFUnUSFT5uVd8OLXPAgmViShplQPbCp89fNkwVIr6W5ju7jB/1+gN2LOhDX3/OWi3RipDtgqOa+G5IOkZKkia8ojhC+/l4sbFyHN6aTo/QrwdcbTvZZNEqq1+n3WDIuVDmOLaap9BoLsY3zqLW6ihA3Ysj4A4x83acM7e/GjNRX/XquaRsWvTOt9SC+1lbrFizUWFenpiZEpR4AGvEHlR+DOO9YUJl5bDwqsBhABE2eozNDbF/R6e/XxUOkaRy8S
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(396003)(136003)(39860400002)(376002)(451199009)(26005)(122000001)(82960400001)(8990500004)(82950400001)(186003)(38100700002)(64756008)(9686003)(38070700005)(4326008)(8936002)(8676002)(52536014)(86362001)(478600001)(5660300002)(33656002)(71200400001)(7696005)(76116006)(41300700001)(66556008)(66946007)(66476007)(55016003)(83380400001)(66446008)(110136005)(6636002)(6506007)(10290500003)(54906003)(316002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?M59yjG/mJc+Cz+hCPKPH1U6cEOIymBDh8ixZvrxjxmCXgABiFK/cZGAqZGzx?=
 =?us-ascii?Q?wk63OkQ5ZcYQB/P9GVq6pPzfpeFYgG3Uw+bVLlvvAOP8AZkVcvyJCIOv8kb4?=
 =?us-ascii?Q?bdWaJnQ2LipA9YEuf9m+JiFUAFRqyy10nolv2l+4ycr/XFOrXIKU0E5NBCQP?=
 =?us-ascii?Q?he895wu+MyBTRw6xZTObVugRAubmj1sHi+sYkZlTNf5Dus2c9Aajvn3Pb44o?=
 =?us-ascii?Q?vt4Lk77M1P/QqPNio+AOjEII/ViLmQGSjtezaXPj4xYosLUWZUhgQTANyzPF?=
 =?us-ascii?Q?EG+mB57TY/8pQeKEy/gvtl0s4YzNNf00Cn3eUDmdqubLRw3hY3s1pj3AWM10?=
 =?us-ascii?Q?qDQC5u6RHGIOmEl305T4ABa+2g2UmYceGbVEUhtukO6OVo8HJJgaZNWjh+nd?=
 =?us-ascii?Q?vsEbpZetwfrTxku07/ME+T5t3lo6rE6nN8ZKV91krFYV4CIct06Vss9SCTog?=
 =?us-ascii?Q?nl33TrP4pDWO7SIjO13Ynw01TEcP6wNs/3EKo9hScJcV2JJfW7kpUDbyYTv5?=
 =?us-ascii?Q?1gAlKxEweLwDpi0XpozzxBJ34bQXu38NK7xhKfmg/GjdZwvj7SOrm79twdHq?=
 =?us-ascii?Q?1nrT+sPPwuCGbSBJSidYYQPcz9PN8cUKeh7Q3gz9W1ldoqrryXBZsYji+iCk?=
 =?us-ascii?Q?DNMyjID0rqinmR8GXosKd6rqZqX1AomxqQUVv/UHtoZOy/X/yyiltT7TfBWz?=
 =?us-ascii?Q?qEgqNP0B6uTjSdc1jtmF7hnTR4X4LBb358J2o5xAkhszZMZg3DEK+K6MZe/S?=
 =?us-ascii?Q?CHINjes3XmzxsMfXph59eEorUD2LLs7EHRV4N7nZWJHdzZOZz6tQyyzmfgik?=
 =?us-ascii?Q?EK6mdhomvG78NIELQX3wBVKaQ63mddfXfwrdMBwFgq5M831J+bjvdSQKK7hZ?=
 =?us-ascii?Q?Bytqnb6Fzluxi3tTJwImWS5TrK2tE0sC9zwzr92xjah5G5Gq0e3+AmnOENzj?=
 =?us-ascii?Q?M3BtpVDfVl1XLAeJSzemaUIXTDBh1Q5E/gXBIu/BH/qkC3u91RdgFyZi1TDj?=
 =?us-ascii?Q?3Qluv2wPPeB1lsNprtGQnFgIa4TyP461us2sXh6aQoCnGihDUmqgNs5xQ0x2?=
 =?us-ascii?Q?slKPlhwRYyzn0ERPPoRSLGfDc8beNx7pkCWQxSyu3kUfVtgd7SG8eimirzBQ?=
 =?us-ascii?Q?8/6IFyhpk8hXJFAgiWM5M7WEGwvR5bg7QQVbrxtpNmDKLJPZMF/DmjJ7+pFz?=
 =?us-ascii?Q?KtLHtnu56dQVuPPywT7KvLh0sENhFrVime/cS4PpiP9th4JlAu5osfWcWv2Z?=
 =?us-ascii?Q?Asqpowd/eEz58gnRq4dmf49Sq0ldcjwZi/zZMAcjrhmPkaxM2rQiGAPATa+3?=
 =?us-ascii?Q?FptME+SWRIaGQrEkP9wjdfvlAifRXLjyQ3xaLnxKIrRaCP1iO3uSevvOW309?=
 =?us-ascii?Q?2H1xg6HqXtTJgB2onD7A34Gm5R/HeNbbIQbmpKBUCcTZ8xOSWVd9cH8nGh9Y?=
 =?us-ascii?Q?IKf98GMOYC5PFPDuwTHPq7c0yb9DXFDn9wP/lBTZ8zF1N/PbRHf4XnoWf/AR?=
 =?us-ascii?Q?PE10D5Jb7AAFb9+HSZqp4eF3WkAq2G8lXPJnycXwWanL09qAgmCp//y318bm?=
 =?us-ascii?Q?OVBvBNsFDqilsBfE4DQHE8dnFdNEG+xBsICt6zOLS0czJtJ7I3pobxzUA7tH?=
 =?us-ascii?Q?ag=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f042ad28-025f-4b29-02df-08da5ea97cbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2022 17:12:06.1501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uYbvx/lanSlkttIZvBI9KnxYVMwzi2PQVX1JrB3174urQuvbbm1pDXo1iPfEabm2bg2MSrDVPNQAIIsxSErVd1paY7udKp5lpc8l7nH2ciY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB2032
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Alexander Atanasov <alexander.atanasov@virtuozzo.com> Sent: Tuesday, =
July 5, 2022 2:44 AM
>=20
> Allow the guest to know how much it is ballooned by the host.
> It is useful when debugging out of memory conditions.
>=20
> When host gets back memory from the guest it is accounted
> as used memory in the guest but the guest have no way to know
> how much it is actually ballooned.
>=20
> Expose current state, flags and max possible memory to the guest.

Thanks for the contribution!  I can see it being useful.  But I'd note
that the existing code has a trace function that outputs pretty much all
the same information when it is reported to the Hyper-V host in
post_status() every 1 second.  However,  the debugfs interface might be
a bit easier to use for ongoing sampling.  Related, I see that the VMware
balloon driver use the debugfs interface, but no tracing.  The virtio
balloon driver has neither.  I'm not against adding this debugfs interface,
but I wanted to make sure there's real value over the existing tracing.

See also some minor comments below.

Michael

> While at it - fix a 10+ years old typo.
>=20
> Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
> ---
>  drivers/hv/hv_balloon.c | 127 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 126 insertions(+), 1 deletion(-)
>=20
>=20
> Note - no attempt to handle guest vs host page size difference
> is made - see ballooning_enabled.
> Basicly if balloon page size !=3D guest page size balloon is off.
>=20
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index 91e8a72eee14..b7b87d168d46 100644
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
>   *		   in the system in pages.
> - * zero_free: The nunber of zero and free pages.
> + * zero_free: The number of zero and free pages.
>   * page_file_writes: The writes to the page file in pages.
>   * io_diff: An indicator of file cache efficiency or page file activity,
>   *	    calculated as File Cache Page Fault Count - Page Read Count.
> @@ -567,6 +568,14 @@ struct hv_dynmem_device {
>  	__u32 version;
>=20
>  	struct page_reporting_dev_info pr_dev_info;
> +
> +#ifdef CONFIG_DEBUG_FS
> +	/*
> +	 * Maximum number of pages that can be hot_add-ed
> +	 */
> +	__u64 max_dynamic_page_count;
> +#endif
> +
>  };
>=20
>  static struct hv_dynmem_device dm_device;
> @@ -1078,6 +1087,9 @@ static void process_info(struct hv_dynmem_device *d=
m,
> struct dm_info_msg *msg)
>=20
>  			pr_info("Max. dynamic memory size: %llu MB\n",
>  				(*max_page_count) >> (20 - HV_HYP_PAGE_SHIFT));
> +#ifdef CONFIG_DEBUG_FS
> +			dm->max_dynamic_page_count =3D *max_page_count;
> +#endif

Arguably, you could drop the #ifdef's in the above two places, to reduce th=
e code
clutter.  The extra memory and CPU overhead of always saving max_dynamic_pa=
ge_count
is negligible.  What I don't know for sure is if the compiler or other stat=
ic checking
tools will complain about a field being set but not used.

>  		}
>=20
>  		break;
> @@ -1807,6 +1819,115 @@ static int balloon_connect_vsp(struct hv_device *=
dev)
>  	return ret;
>  }
>=20
> +/*
> + * DEBUGFS Interface
> + */
> +#ifdef CONFIG_DEBUG_FS
> +
> +/**
> + * virtio_balloon_debug_show - shows statistics of balloon operations.
> + * @f: pointer to the &struct seq_file.
> + * @offset: ignored.
> + *
> + * Provides the statistics that can be accessed in virtio-balloon in the=
 debugfs.
> + *
> + * Return: zero on success or an error code.
> + */
> +static int hv_balloon_debug_show(struct seq_file *f, void *offset)
> +{
> +	struct hv_dynmem_device *dm =3D f->private;
> +	unsigned long num_pages_committed;
> +	char *sname;
> +
> +	seq_printf(f, "%-22s: %u.%u\n", "host_version",
> +				DYNMEM_MAJOR_VERSION(dm->version),
> +				DYNMEM_MINOR_VERSION(dm->version));
> +
> +	seq_printf(f, "%-22s:", "capabilities");
> +	if (ballooning_enabled())
> +		seq_puts(f, " enabled");
> +
> +	if (hot_add_enabled())
> +		seq_puts(f, " hot_add");
> +
> +	seq_puts(f, "\n");
> +
> +	seq_printf(f, "%-22s: %u", "state", dm->state);
> +	switch (dm->state) {
> +	case DM_INITIALIZING:
> +			sname =3D "Initializing";
> +			break;
> +	case DM_INITIALIZED:
> +			sname =3D "Initialized";
> +			break;
> +	case DM_BALLOON_UP:
> +			sname =3D "Balloon Up";
> +			break;
> +	case DM_BALLOON_DOWN:
> +			sname =3D "Balloon Down";
> +			break;
> +	case DM_HOT_ADD:
> +			sname =3D "Hot Add";
> +			break;
> +	case DM_INIT_ERROR:
> +			sname =3D "Error";
> +			break;
> +	default:
> +			sname =3D "Unknown";
> +	}
> +	seq_printf(f, " (%s)\n", sname);
> +
> +	/* HV Page Size */
> +	seq_printf(f, "%-22s: %ld\n", "page_size", HV_HYP_PAGE_SIZE);
> +
> +	/* Pages added with hot_add */
> +	seq_printf(f, "%-22s: %u\n", "pages_added", dm->num_pages_added);
> +
> +	/* pages that are "onlined"/used from pages_added */
> +	seq_printf(f, "%-22s: %u\n", "pages_onlined", dm->num_pages_onlined);
> +
> +	/* pages we have given back to host */
> +	seq_printf(f, "%-22s: %u\n", "pages_ballooned", dm->num_pages_ballooned=
);
> +
> +	num_pages_committed =3D vm_memory_committed();
> +	num_pages_committed +=3D dm->num_pages_ballooned +
> +				(dm->num_pages_added > dm->num_pages_onlined ?
> +				dm->num_pages_added - dm->num_pages_onlined : 0) +
> +				compute_balloon_floor();

Duplicating this calculation that also appears in post_status() is not idea=
l.  Maybe
post_status() should store the value in a field in the struct hv_dynmem_dev=
ice, and
this function would just output the field.  Again, there's the potential fo=
r a code
checker to complain about a field being written but not read.  Alternativel=
y,
the calculation could go into a helper function that is called here and in
post_status().  I'm not sure if it is more useful to report the last value =
that
was reported by the Hyper-V host, or the currently calculated value.  There=
 is a
trace point that records the values reported to the host, so maybe the latt=
er
is more useful here.

> +	seq_printf(f, "%-22s: %lu\n", "total_pages_commited",
> +				num_pages_committed);
> +
> +	seq_printf(f, "%-22s: %llu\n", "max_dynamic_page_count",
> +				dm->max_dynamic_page_count);
> +
> +	return 0;
> +}
> +
> +DEFINE_SHOW_ATTRIBUTE(hv_balloon_debug);
> +
> +static void  hv_balloon_debugfs_init(struct hv_dynmem_device *b)
> +{
> +	debugfs_create_file("hv-balloon", 0444, NULL, b,
> +			&hv_balloon_debug_fops);
> +}
> +
> +static void  hv_balloon_debugfs_exit(struct hv_dynmem_device *b)
> +{
> +	debugfs_remove(debugfs_lookup("hv-balloon", NULL));
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
> +#endif	/* CONFIG_DEBUG_FS */
> +
>  static int balloon_probe(struct hv_device *dev,
>  			 const struct hv_vmbus_device_id *dev_id)
>  {
> @@ -1854,6 +1975,8 @@ static int balloon_probe(struct hv_device *dev,
>  		goto probe_error;
>  	}
>=20
> +	hv_balloon_debugfs_init(&dm_device);
> +
>  	return 0;
>=20
>  probe_error:
> @@ -1879,6 +2002,8 @@ static int balloon_remove(struct hv_device *dev)
>  	if (dm->num_pages_ballooned !=3D 0)
>  		pr_warn("Ballooned pages: %d\n", dm->num_pages_ballooned);
>=20
> +	hv_balloon_debugfs_exit(dm);
> +
>  	cancel_work_sync(&dm->balloon_wrk.wrk);
>  	cancel_work_sync(&dm->ha_wrk.wrk);
>=20
> --
> 2.25.1

