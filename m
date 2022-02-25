Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFBF4C4E32
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Feb 2022 19:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233935AbiBYS74 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 25 Feb 2022 13:59:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233868AbiBYS7y (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 25 Feb 2022 13:59:54 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11021022.outbound.protection.outlook.com [52.101.62.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01AF01FE541;
        Fri, 25 Feb 2022 10:59:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KPWbtJGxu90QDcdoDeC6fb1cebxLMQitRGbYrnsKeR70mSZx2GQm2V8SNgUtrwjxd0JgQNboEa0T5uKJH5C4Pz8E+GdTjWuKQ010Oke8eOnqXsp9aw2lXYbjwNKCgCoDQfZ1AmTrHss6mhSoSflBkiAGsxVrjxYmxQ6+DSbY9IBLDEtQ3xTrNf+bzGSeXVuiiFKWczj4kXe7nIkAKsd8NtFQrIa3i85bbpj23CzjmAAAYerkwyDmuGD3pzRQ9ce5YYMENyHAz7JFY3U4qYzM8GNK1yP/RXLCdBnFZTmoun94G8/wp9GTW3CMK9lb3ETiuL0+tgGf7tS/krSWBg9kdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XEqkPz+MyThBCc/tTcAAauHSpr+BjYsMpS/m8y/IDOc=;
 b=PSg7KqEDAxfrb7UonAKgXZVMJ2qxMOJjQISJ4hcSFdTndaGaEem6RKKETWzqjzRMS/b649CmvxYY03ixHuH6npOzgAUYjAHjGkMjwOIC0zvyOEptgo+selWmS/Z7cmjITb42nUFyXLtUz7+J9WXh1fR8r5zKYx/4RoVUBw/mEOmToyYAXNWyLlp4489OomMalZku77zMeRIOkjcHYZ8HgeE7tnzynAXmhf1qVlTDyBunExgkHFKxAB7G6NkQDS/O3XLizBdRpCrE4a5ZwZvdXevzqPIq3nxucdMKrSgGyY1kpEr6hYTk21I5YbvOvPab9SGADVJ+epi4uy/utHDHhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XEqkPz+MyThBCc/tTcAAauHSpr+BjYsMpS/m8y/IDOc=;
 b=Re6DWYTgGV4Sj0v5cWCuwvyAkZ5+T9DzRSa5gCyzISMxcsjdfSxngc+lqPV/JBbv1PA4/WNcl3x5LKzZGNZxIKz/pYoEIdkZfLu6AxcJ9M4ugyoLz4F59ps0P2ii0ke+tNnc7wTbI/EYO2oKVFOPkj2PMV5zBFRabN7wRQEuHfw=
Received: from MN0PR21MB3098.namprd21.prod.outlook.com (2603:10b6:208:376::14)
 by SJ0PR21MB2015.namprd21.prod.outlook.com (2603:10b6:a03:2aa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.9; Fri, 25 Feb
 2022 18:59:19 +0000
Received: from MN0PR21MB3098.namprd21.prod.outlook.com
 ([fe80::69f8:51be:b573:e70c]) by MN0PR21MB3098.namprd21.prod.outlook.com
 ([fe80::69f8:51be:b573:e70c%5]) with mapi id 15.20.5038.006; Fri, 25 Feb 2022
 18:59:19 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Anssi Hannula <anssi.hannula@bitwise.fi>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] hv_balloon: rate-limit "Unhandled message" warning
Thread-Topic: [PATCH] hv_balloon: rate-limit "Unhandled message" warning
Thread-Index: AQHYJ/eP+P92t79ZhEqBs3JJG71Sz6ykoZ9Q
Date:   Fri, 25 Feb 2022 18:59:18 +0000
Message-ID: <MN0PR21MB3098049BCEFAAEE5C61F589AD73E9@MN0PR21MB3098.namprd21.prod.outlook.com>
References: <20220222141400.98160-1-anssi.hannula@bitwise.fi>
In-Reply-To: <20220222141400.98160-1-anssi.hannula@bitwise.fi>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=48ef8e2e-9ca7-46fe-afab-097db867915a;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-02-25T18:52:03Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ee754a1-0733-4740-1a5f-08d9f890ed5f
x-ms-traffictypediagnostic: SJ0PR21MB2015:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <SJ0PR21MB2015633F04C108BD4CF68F60D73E9@SJ0PR21MB2015.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SnYsWs2dp6mge9wMuIOCA7jPfjvoLDqbJSHpqW/faAc0xKxNkTtIpP0op2Gnpo7eT27PeiT9iguy7LhFqrVu7iVHtjN+q5fPMJepCuGIVsFxTbBOdi+8d8Shlz0jJ00Dign/4lzKZjLsH1oGwbAL7+F2lEz4y8rnEgknTGn40/w+bs7YP7+7vXy08tD/ew6RWAl2cf3HEZigfMAXiusuYXR/JvYnmGwmgkfvtcDVhMWPyjicgmNLE9ldWbBTSCAz9lqs94536toQ6FWhrZdG7Q6XtKAOJ48gS22AIq7Zm0DMR3scXPhbJZVBgAI5hGPJeXUR15HmWeMcWjGYznsgjyjccAN4nbemIJ0OjyYjddjTkApGuDiUpFe0VUEPy29c49POWjb2DxNip6O5xdlVSEhGmplpcdV/mBlP0aMIH4OEE1QBZdZUIFg0KgrZQDry7MoXWitho2wDIvms5M1MDOEhTEbKHHbP7boJjUysrfMTzc9dx9PDvZJQpEMJV+iYwRpgeA843yLPZyJFm+5q01gKOJYHR7ru6AWYr163tNEVppkw5m/kf1e/vyJ4ruObomU6FrOSnaMJXu8mbDaXYHT0diA1vJJD1jiCKksj+M8VmAj9fd6VQvhE07Eug3tk20SziWxnDB8QDaxw8zdHNUlR0Lwe2yrHJfBVErq1ZgRYS5ivGms88KO326ote8wbWHmfPQCmEZVNqO86lh6IDCSs9VI597u1wCC8e/s9jb1EzkMfQG4WxbT2nQ/fkzFW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR21MB3098.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7696005)(6506007)(38100700002)(15650500001)(82960400001)(5660300002)(122000001)(26005)(6636002)(82950400001)(110136005)(52536014)(8990500004)(8936002)(54906003)(186003)(316002)(55016003)(9686003)(38070700005)(86362001)(508600001)(71200400001)(10290500003)(66946007)(83380400001)(76116006)(66556008)(66476007)(64756008)(33656002)(4326008)(8676002)(66446008)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?I0G1uC37ftftVTHg1sTfkyy9PwFC7ZHgEVWDdSmDxpC2jqjn/LdMsCB420C+?=
 =?us-ascii?Q?K45mDqTkYaKhQHmDnwK6DlfPGToldQU8meF+8XlzFX34ICAxDwlE9nXtzrIv?=
 =?us-ascii?Q?jTdxODL0+hOw/qAOpkbXdGaeZQtFFm5KSYZCj9Dt6G7wf+vng7r2wHZ/EuWH?=
 =?us-ascii?Q?A+EwqdN0eyFvEhkRxsFvJR3TVuVkasdvarh8F01L9qWe/Qcznz0yi6FBXgfF?=
 =?us-ascii?Q?GO785HJtN5OsLu8Go6KGO3C1zAHPPUW8wNrgiTOVy/vmEK1idzKb51X8WF1T?=
 =?us-ascii?Q?OeKbopBX/wz/9D3U/nk1+KEblTmAu3SzZxAR9BooBJOv0rYwbpZ12JI1OCwS?=
 =?us-ascii?Q?LHR74zyHPqcBRMXhtwr9V9aaKGrm0CgtGAIqrg92skWz2BPQdEZpVrCNeQL8?=
 =?us-ascii?Q?Q0qw78btUjlbbe9TxT91bQH+BVvKC+Gg71gVVYv8bVkdwPOOqkI4ehV30gsZ?=
 =?us-ascii?Q?lb0eHLimzwSyQA/vSR8uI5PR70VP/rWX0Kjq7lr65PSsEyEF+CNdjd24rada?=
 =?us-ascii?Q?sFBDhlZlVNCU3mlDVEOisMFYXGJZ1NDoktn8GVISyhQvYqMAriHyeBwu7u5z?=
 =?us-ascii?Q?JFvkR0sF7edk/UULKqYrDDPYW35sUzBJ4C5QsF3LErnk1X7f3qnm01wxO3J1?=
 =?us-ascii?Q?n+sCY5Y4ajR0YvVHXBr+wk3NvOyAmJwgcqpUYLhyTZeqfM5W5mYXxmevK3FX?=
 =?us-ascii?Q?j+xkdgHNJE7z0YMpLU44pBw2SP/pJzQKQwnem0wR1i+m8PhdSy7oYv5YoKub?=
 =?us-ascii?Q?5cCsCmFg4S0HLqZr1f10jrq/t2xJtMBvMhMGZwv4ST5leC24B/7bDNNHSDHA?=
 =?us-ascii?Q?stBWDO6VURGiJM/9rKKZHK1x8cyYoTXQMmDcrHuU612bp85XTXrLntNR4dx0?=
 =?us-ascii?Q?aJwydGfAWDumE40Vowi3OgJM/GZttjSo52Q/0LqzoLkAe5+aneDtn2kXrm5d?=
 =?us-ascii?Q?QwvlcHI7MTpKi/L7ERp0DQZhPf7YKn/cSeCkqmC5Ox/ZIeEmNrK/5t/qkkuD?=
 =?us-ascii?Q?hv0znQrFw/Y4r4WsXelHi2tgPRptogjH9IxZySMGS71+1XKMire48rkhuuZs?=
 =?us-ascii?Q?AClUJddTUS+EFLbET+VjUIOvzXYL+FwPEDofUDxFnUv8QiUD/aPyvlfM1igC?=
 =?us-ascii?Q?xoyuQKsEylVHBHWmw1H3S3lXIJUEuaqyk9zM1fZhy212xbjWS/50hOmZMxl0?=
 =?us-ascii?Q?1FGXPtU7CLC5kkRsQqcXtZLOBL+nd9hXvTslGe+NW6pgAOtEIx8MDbgRsv8y?=
 =?us-ascii?Q?0ZquTDWya1Chm8VZpmXh6wTpkKFNokvrXshd+M2jInRon8/nEndi4SQP0/7V?=
 =?us-ascii?Q?+Xzrf8pcg5fW6I7hJqe4NcE3qgQJmSCrPE/3NVg3R0bOeLrEiIrJJDWiWnFm?=
 =?us-ascii?Q?e3rdOo4bgxC00lgIYKzX4k6jM5e84U18R8VDO5upGFFkM1/HHUxMytGNudQj?=
 =?us-ascii?Q?TMg1+l0m4+VLLP2jvW67WGJmRkhmmewgapXSfxrGUnqM7cjIIqwKKNI2da9C?=
 =?us-ascii?Q?3RnFbT6QFxrkJ0l6DOYrvqD8g472CK+4tXFK7aXnDmCc+6vDqY6E8M2/97SS?=
 =?us-ascii?Q?ZQ3DreaJpFeFtqoUvIvyd8KlTjQcIIwI16uYIAPD1+nF01YytkuoI51ADHl6?=
 =?us-ascii?Q?YAZlLtd+nYIDkMs1Dtba1jNIO1umBQrDaXhQn2AvetiyNZMkWGaNmwNvGMXY?=
 =?us-ascii?Q?DoYEDg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR21MB3098.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ee754a1-0733-4740-1a5f-08d9f890ed5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 18:59:18.9298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O755T19+IhByMFhPGV9BG8a+W0J+bnGT0PBzCDC9UvPZ39qwQYPdfvem2mK5SUFB8kf1+P2WiAs8oFg5Btg5V9jplkO7Lu5Tr9po5vd+9qw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB2015
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Anssi Hannula <anssi.hannula@bitwise.fi> Sent: Tuesday, February 22, =
2022 6:14 AM
>=20
> For a couple of times I have encountered a situation where
>=20
>   hv_balloon: Unhandled message: type: 12447
>=20
> is being flooded over 1 million times per second with various values,
> filling the log and consuming cycles, making debugging difficult.
>=20
> Add rate limiting to the message.
>=20
> Most other Hyper-V drivers already have similar rate limiting in their
> message callbacks.
>=20
> The cause of the floods in my case was probably fixed by 96d9d1fa5cd5
> ("Drivers: hv: balloon: account for vmbus packet header in
> max_pkt_size").
>=20
> Fixes: 9aa8b50b2b3d ("Drivers: hv: Add Hyper-V balloon driver")
> Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
> ---
>  drivers/hv/hv_balloon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index f2d05bff4245..439f99b8b5de 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -1563,7 +1563,7 @@ static void balloon_onchannelcallback(void *context=
)
>                         break;
>=20
>                 default:
> -                       pr_warn("Unhandled message: type: %d\n", dm_hdr->=
type);
> +                       pr_warn_ratelimited("Unhandled message: type: %d\=
n", dm_hdr->type);
>=20
>                 }
>         }
> --
> 2.34.1

Unlike some of the other VMbus drivers, this driver has not been "hardened"=
 for
use in an environment where the guest does not trust the hypervisor, but it=
 was
affected by changes to the underlying ring buffer handling.  The bug that c=
aused
the flood of errors has indeed been fixed, but I'm good with rate limiting =
this
warning.

Reviewed-by: Michael Kelley <mikelley@microsoft.com>



