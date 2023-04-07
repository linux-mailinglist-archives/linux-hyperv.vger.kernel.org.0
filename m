Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002336DAF9A
	for <lists+linux-hyperv@lfdr.de>; Fri,  7 Apr 2023 17:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjDGPW2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 7 Apr 2023 11:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjDGPW0 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 7 Apr 2023 11:22:26 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-cusazon11020023.outbound.protection.outlook.com [52.101.61.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1494C31;
        Fri,  7 Apr 2023 08:22:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LbR1xr08jzub4Srgaee6MSd+9vz4yT2iDm03SfXwRPTd6BVDJpQrUgKGi57TAaVr/QifAFlqDV6D2qD6rUquKsCxBQsl6iQuFFGiiQ7eOG4tVDScvz/rlP52jMq4vfK5Jx7tLco9PRN8O8fzm3SvQBYmiGlg7CbyZjsiZX00CRPlzHjcFVIQKZO0VFuPVuRUrZJPzfof2gY+Jxagn+aJBIfGQL9GV4WLWB73G7/d4jVOk6ddI55tzZ01IsNsQu3q2dMJjN+kmWIcSMJ0gU96PyNAvdaSRRBrrmR9CqXb4YYCp4o9qLQpOC9ZKouAar395kHUtxHUpc+07fZicpBRCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GrA62d9Z6vKvmziFWVP1xUvVvbKnD8/BvKjZPrJHzm4=;
 b=FURdAiZEzlKQ/QFhZt6nkKFwQCPG0GoVZXthtfyAKVxHdqVYb4OLUHN6+4Jj2wu8tr3OYQgVJleT8uSCPEOtYV9jmd/ogHvyp6lq2TiPY4wmjUUO8QHpYPsq7S+n1oenypsvHHUf9RTM49mTbYj0f75PvvEy1LyepPRXoLD5Ki/G2oec5V6oh1B1wSeKUem9e6Cor0g8AE2Zatrf1m9cPtVJIKRrg9vc06UKl21fj7MfhhHe7gujWAVLElgbzisbyBcdldt5ktzQc5QEop2+h+mvBWBmYmIPIXY/Ab3nVdDsi3j+KoRbGv6NWFSAYK0NNJnxV6+a2AVBXcg07+tyVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrA62d9Z6vKvmziFWVP1xUvVvbKnD8/BvKjZPrJHzm4=;
 b=Q1jpaoz4hrRQrfuSGZdy5ugpLlXmt2K7zGmef5FCYY1pSaA75BZcrNDnzuTtXMP1SCGyp31ieoycTbK7wcUYLRa/gUnMZ+5UbWuTz2pUUvG+rjWoJBU9Fo+vQ6Vejjwg01e2osQ1m9qezo4getcavAMoyL6WyVFT0TUUN3LND7M=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by SN7PR21MB3886.namprd21.prod.outlook.com (2603:10b6:806:2e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.18; Fri, 7 Apr
 2023 15:22:17 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c%7]) with mapi id 15.20.6298.018; Fri, 7 Apr 2023
 15:22:16 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH] Drivers: hv: Do not free synic pages when they were not
 allocated
Thread-Topic: [PATCH] Drivers: hv: Do not free synic pages when they were not
 allocated
Thread-Index: AQHZZoMjvlqzQzftXUea70v33me3o68f+VGQ
Date:   Fri, 7 Apr 2023 15:22:16 +0000
Message-ID: <BYAPR21MB1688A4EA2E802B66AADC3324D7969@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1680564122-30819-1-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To: <1680564122-30819-1-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=dbe0378d-a0d8-4cf5-91f3-27bc49513503;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-04-07T15:11:04Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|SN7PR21MB3886:EE_
x-ms-office365-filtering-correlation-id: a498e60f-54b9-4d75-8217-08db377bded6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sn0NrPmYdHYGdUARkh4yc+QBW+EFmrdz3dxOtOgK1+3Bpwys8T74xwrY7Hltkpk6+/55aC30vwXMRDw1qkR+ur6/effasUMkby9KUdZGuXOg6AFBEY/LD9qDlwtycNoJoGdC22YcS49wHRAoCWO8spUef5+fcXHqOGztdjDtpGJTf0GpPr7btbbrugDQkMDqKtY4HlRcimQ1SygTGYWrwi35LOGi4xcmpPsviX4UozRDVesEQPLeDhEblu5W5WiG45RCjUdU9UtwMnL6/XQxpVPJWO1kW2ZiQV4ioXdwGZ19g02s5X5pub9STk5YE0TiOb3GS7gH6nhuWPAwjYjCgvaIib7x6zFxALFfkyWy1M7r/nug10UNTaVTASeF7XP5Q9DhB6LHHRgMdImyx7OjF89ly5A4z8KNY4hPAt0WN1BbwqXr7UJNoYf2Q+1I7A7g+3gaE1OFOWCGJmob+z6hN1+AAOBkvOQnpLNsbKGBoqse5tsogTRbqn6zxtWGrv+Nrk6hMuJAgThVGigsxI0oes/cmlJxx+BK+CzdFsAZuO0acm1pmbF11sZOWllOgUx9fa44a5QWjtBXvnum861ssC1Gld3bGZuLBjNl+VnYgtaKdc6hinpST25qdryQGIvf6lGfxwicIgYC+Qdht/Q6/cd010qqBcdiqxBJ+iE2AFI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:cs;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(366004)(376002)(39860400002)(451199021)(71200400001)(9686003)(26005)(186003)(6506007)(7696005)(2906002)(107886003)(5660300002)(41300700001)(64756008)(4326008)(786003)(66946007)(66476007)(66556008)(52536014)(66446008)(8936002)(76116006)(316002)(8676002)(110136005)(54906003)(10290500003)(82960400001)(82950400001)(478600001)(38070700005)(122000001)(38100700002)(86362001)(33656002)(8990500004)(83380400001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HfvLClweWxOCv0qGYM39w9LNFCCIySDxRzWrG0ZlNL0z2mGX9kGDDYhPGwxq?=
 =?us-ascii?Q?+M84957afI9XSY9+VhktwSTT4J/xoxUp0k9YApwtleU0mWImKjMveVwvUAx+?=
 =?us-ascii?Q?huAHNh0yzhQnx9RHDRhY3NQmZFXzBNschCwSiO20XJ9AcyFPYoEI5/JGebNL?=
 =?us-ascii?Q?bEJXVph4T80i1Djh6mmaQ4NfU4/KXNntTuk+wrYjywL8QzbElF2IHQcEFZkz?=
 =?us-ascii?Q?7vAHUlQ5ejrT/EbwgK0CM+ncFHQuZRWLnXUFAUXtQfJo5vrDwNqvXPXOXYfC?=
 =?us-ascii?Q?yzkgsClarvKSuvK2w5B4+Wd5eEle7ni6xbP6Y9LVQ2Io0X37vXi6HiBWGpsK?=
 =?us-ascii?Q?nA9CkSM3vC2WmNN+94nX4fiFPJHwKX0PX4bMOA7RZmdkWLReWmnb4Ns0mK5R?=
 =?us-ascii?Q?LapSiLErArO94zWqv8PMTJIBBJYKgwhLrBHMRPurgqpkQJpNMKupznO5Lk35?=
 =?us-ascii?Q?WhW2wpgs8XaU59TZL4L+HCD88WhESG9bZE6hklnAVzDizhhjwyptHv2wcKQ8?=
 =?us-ascii?Q?3W9HY5d/AFJV7o/xGPFf6A7B9dF15BkqO24LJuXllKxO/uqM/NDo3JsshLaX?=
 =?us-ascii?Q?iAGd6IYtYvHl54/XnrvBMWmiXGOdtBSXgX2qev3pxNR8j/rmri+elRq6FrmS?=
 =?us-ascii?Q?HTGYKCAvgIX2M79jk6qo+YiewkhQWcDXNwoJ4ADmnpwYFArAmKHyJe3zF3NS?=
 =?us-ascii?Q?kiNGn1CTiJ/htYmsC56OFXQJNQ2dD/GFPFHc8jU8x3Jq0+1NGlEucQKABPQj?=
 =?us-ascii?Q?hi8mmpE3cGZZh2MqU761juwbTa1/6uB3CpDuGP3JNazqlQhEhj44oVmvE7Gz?=
 =?us-ascii?Q?f+EPjX58Xxuci4VTCdX8TfMyDeTO3/sHiSZEddovLp8HplQoA48lDtBJ56f5?=
 =?us-ascii?Q?bEwn1ti8Gib+OwsvOyQnJLArn+dGbVDtqVlnx/toJfShE465MH8PjgsQ9V/1?=
 =?us-ascii?Q?Lg9VhXWCn9Oq2YrDWpR2ip6E5d0F4Pngwr6pt7/tl64IhW9oLdJrlDFDA/2U?=
 =?us-ascii?Q?Gj/Ki2qQBx4lQAsSQzq0H28v+3/Qj8iFV5Q6nGnkgHEeQP5Ey/ZuqE5bXQAW?=
 =?us-ascii?Q?4ufFb7JcR+Ja9iaM88SMajN+g9E5ReXnFQyjnGNvLAP4c4lFpxVzBwAn9FHt?=
 =?us-ascii?Q?YnYrZNRIjwKdtZ/V1Bj9e3NenQVsOA3CF3rcHBxhL+9cLVcklKiNUUsfmH2p?=
 =?us-ascii?Q?W5l9+TNXAhSdoX839LujBWn5wKzDyVlqmewIZDZ/J8x6TQ68gJ/24jlR0a4K?=
 =?us-ascii?Q?f8ApOml0sQ4VMA1dh4Ul072mczFehP1kn2mRHmm/1uFh2DhWyWbSrq8odfPK?=
 =?us-ascii?Q?zUfN5I6PxKHu2To6K1azXdPxV36BVkOolZyibotiXYRIoPtJbFCpaN8afnul?=
 =?us-ascii?Q?CYROHmZBJVSWqt40FTDIQ2xcZB+gP28FB7dTUPToc5afkHbM+8fEK2mWcWR5?=
 =?us-ascii?Q?2ruzR7VW3qzKrCffdt02YDRPkemtqx5OBu9Ts9VFpmLhStB52dsNNDWQc1yI?=
 =?us-ascii?Q?VgCb6e3VyKV2CU2K8guHraIgh1EhjIlVp6F0fKGkTwFxVT3Rz4ITkkg5xyHk?=
 =?us-ascii?Q?V3JdxNyz5l6SsBpegy70X1WSddPb3Tg4qW39oHuE+QV547na7wKTnjaQNGg7?=
 =?us-ascii?Q?YA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a498e60f-54b9-4d75-8217-08db377bded6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2023 15:22:16.1924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uwjcA86IWeZ8uP9HHJvqtQ+lK2LPNMWToo4QAicaEWzPoc29FbQb24oN0xUQwLRvfNsbCA4Ly6rk4orv9/mgDrSd4rqsiTO1baTeP2S6xF4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR21MB3886
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_NONE,
        T_SPF_HELO_TEMPERROR autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Monday, April=
 3, 2023 4:22 PM
>=20
> In case of root partition or snp, the synic pages are allocated by the
> hypervisor instead of the kernel, so they should not be freed.

This patch doesn't hurt anything, but is it really needed?   In the SNP
Isolation or root partition case, after hv_synic_alloc() has run, the
synic_event_page and synic_message_page pointers are NULL.  Then
when hv_synic_enable_regs() is run by a particular CPU, that CPU
maps the pages and the pointers are non-NULL.  But the corresponding
hv_synic_disable_regs() sets the pointers back to NULL, so
hv_synic_free() will already skip those pages.

Is there ever a case where hv_synic_free() would run after a CPU
has done hv_synic_enable_regs(), but not hv_synic_disable_regs()?
If that were the case, it seems like we would have other problems,
such as missing calls to iounmap().

Michael

>=20
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  drivers/hv/hv.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index c7f7652932ca..a10cf642c9ad 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -193,8 +193,10 @@ void hv_synic_free(void)
>  		struct hv_per_cpu_context *hv_cpu
>  			=3D per_cpu_ptr(hv_context.cpu_context, cpu);
>=20
> -		free_page((unsigned long)hv_cpu->synic_event_page);
> -		free_page((unsigned long)hv_cpu->synic_message_page);
> +		if (!hv_isolation_type_snp() && !hv_root_partition) {
> +			free_page((unsigned long)hv_cpu->synic_event_page);
> +			free_page((unsigned long)hv_cpu->synic_message_page);
> +		}
>  		free_page((unsigned long)hv_cpu->post_msg_page);
>  	}
>=20
> --
> 2.25.1

