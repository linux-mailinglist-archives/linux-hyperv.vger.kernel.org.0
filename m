Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBC63F7C3B
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Aug 2021 20:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236809AbhHYSeE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 25 Aug 2021 14:34:04 -0400
Received: from mail-centralus02namln2008.outbound.protection.outlook.com ([40.93.8.8]:12175
        "EHLO outbound.mail.eo.outlook.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S236317AbhHYSeC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 25 Aug 2021 14:34:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EezlsqbE/D78WxGt4d5YVBfdV3NJUfJAa3GxMUCLeyydM9iKdJtUh6PaEX9a7rDsDUETw+6aAqoGdMNo923SurmYqLbu4A2dkUkx9E3Cz1mT4gLbWYfGdOEaYcGGIW6YdK4jZ5+IiTluGpb0ksK9RgxwY9eLN37arAjfedHSfjfWWK7HPlR3xPEoh2kerVUdEzmhlQ7QupwwiNp/RcKv6Vt6miTxumIq9DOZMttQhy05oaveURxkClW2yaR/+eWs0E/p+QBYjksqAX/M409QZyqhpdB92NGOqCgTu2bnIFtxXffeBpGQAy7TbsMFxEdffyEQiaIzLZ5iVJNiqK3LOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=NkSt4M/b1Uuu7Bj/SN9fHAtHozhqTh6vf+EToAGXpLM=;
 b=NYoAabbmAXARX9cXT+j43ataoG5UROfjY8wYI5+lqctU0uVC6RYErxpET0hVOQBSjt/Byr2tWErscuxzdcVWWMwjXiTinEeFKle09QjFX+XfEqxlJWfEc6YLXFlRJrYsLP1ojTHGYYHLzSAKlQO+z5PVIwa7+9hqb4cJocU2jwKXtpI9qIy+WEGyAZO3ub04s77Dr2crftw0RFd4whsiDd68fJEQo/JBU0E08RDF3KzLkb4J7RayG1LoHvyy/RBYxwIY8LgD0ix+7EUyxm3kWsh3+tSYp+Q+xUO3ZwJMXOveP6wj3cGpYFsiVHrE+KJRo1zARS42oxK8JUZdRvLO9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NkSt4M/b1Uuu7Bj/SN9fHAtHozhqTh6vf+EToAGXpLM=;
 b=QAB7yKvcQw1orHgsuA0/ZRh/3VG+mrdfCp1LzVl+ZOsiamYfRrNw5GpMvfQ+iBi6XLuJ2jvFsLDxl3sxzpokebSgEzsNomV30SGHaEo5CEzZxrDuoeNFUtkVNDjkZx4XbB6Ss4fPfR+FrAn2UNKALDTJ116eda9ZmujyE7R1f0I=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by CO1PR21MB1313.namprd21.prod.outlook.com (2603:10b6:303:150::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.5; Wed, 25 Aug
 2021 18:33:11 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::3c8b:6387:cd5:7d86]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::3c8b:6387:cd5:7d86%8]) with mapi id 15.20.4478.004; Wed, 25 Aug 2021
 18:33:10 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     vkuznets <vkuznets@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     Andres Beltran <lkmlabelt@gmail.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] hv_utils: Set the maximum packet size for VSS driver to
 the length of the receive buffer
Thread-Topic: [PATCH] hv_utils: Set the maximum packet size for VSS driver to
 the length of the receive buffer
Thread-Index: AQHXmbaUNIgJapnVhU6HmoUvQ6T8zquEi4Bg
Date:   Wed, 25 Aug 2021 18:33:10 +0000
Message-ID: <MWHPR21MB15931C94B84D62C451163BAFD7C69@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210825133857.847866-1-vkuznets@redhat.com>
In-Reply-To: <20210825133857.847866-1-vkuznets@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=870d5b01-07eb-4486-bc77-c5f0a810d72d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-08-25T18:31:47Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f47d3c8-2074-4508-9446-08d967f6caaa
x-ms-traffictypediagnostic: CO1PR21MB1313:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CO1PR21MB13132FE4DBD3CF13CF4D73B9D7C69@CO1PR21MB1313.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iTKdgYjceGtgtEXZ/idrv5aYV1QPNSSiQDsrLDLbFXZeBkptTIhfx3OnY10h3CMtsS71moCUliIPGY5UeEwOM3pJ+Pu4Jm9M03rQPiVA+WJtOXiCVrcqdLx7+BYz7mS2RFQ7LH14IzKXUv2xLikenzO6LrCFqd8WPx/9+4A5UaASJXCP5TQLLT+ORuJniti0AxLLsTeV6I2ERePGMp6cIUBf+lxFuvyNfQXak4x15tG89HSlcaU9iIdOa2z8fGQJ2Tkam1YdndemcyQ3DTs2C/eRkL7iq4GMQfHUxA+cjT9Qd2e3Lf0LcL9g5rGSueRY0mFyh0oxfdwq3Ma2WqwqX498r/xx0r9k1/KvWLMRXkIExXO3c7H1th1PZPSCPuxoFkTqpiGguL+HdcME2RU9qPsnP67dfh8BsxM8QCNskS8YJ/HBznXgIJxEUtIFtmRcEOypWXf/ybEM33C8FeCUmUCIdajJCQGDca0VGpagranjSxPZciOmycSY6t8SIv6KceMjqk3d5BVpPX9kgipi9nRiYlXKAFWUFrCfwBb6cxeIjpro9QD95IiNb9W1ogqAUT1LTX61pIxWjrtdcCI2uLnTxlVj8tkz5BfONywolrCWIpZIYD+j6dohy3Ba19jxzGE+EfdENYlaCYMR6rL7JbqdVci7w+qOaJ3ptP9lngWMt2GpZ3f2rwphYdNBAOz98qMnwVIOYBJAXAM6uHICeQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(316002)(82950400001)(110136005)(82960400001)(26005)(2906002)(9686003)(66476007)(508600001)(52536014)(54906003)(33656002)(76116006)(8936002)(8990500004)(71200400001)(5660300002)(38070700005)(66446008)(64756008)(66556008)(86362001)(7696005)(6506007)(10290500003)(83380400001)(4326008)(122000001)(8676002)(186003)(38100700002)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+UfbcWVvYIfROQpOuASOzJJdocPj3bdQ/DLAo6QZEpXxa+9jV7fDnr5ggCCX?=
 =?us-ascii?Q?4EHJZD7N+v39WbOt2BsWp1Mr+qgD86SMnenn1cr5SgufCB8Fk8xMMmLjyXW0?=
 =?us-ascii?Q?CbL42yWj6SDGPH3rWstPheiAyJ+EM7qlyzhU4jWRBXijSshV7iUb/0J/CWQQ?=
 =?us-ascii?Q?aLTraXV3Qfo4BJmzlPKQ4zP/ewTqZ1XPQUzvhjLXCjEzQwwntrQohSwWp9u8?=
 =?us-ascii?Q?OglqNmVSHq7WHL1yzy7dNw5v/VzQDkdYFv6XV1dH5VFEhkn8a5CusFg04bHO?=
 =?us-ascii?Q?r6FPQJ3o2ZAj55F1cBOWIob537m0WBgDGy1ZOtwdvQauEQKWrMqYk/obRvOi?=
 =?us-ascii?Q?5fLY8MzgI3uXAIXznY5TTi6V8N0YIJcLolQJR+5Gfq1n/EBXSbe9SSohiex3?=
 =?us-ascii?Q?PDHNfn/JZ/0JBx6AGEiFlwGUZ4qj/xH8AjlGQvkP4+JOFbg4eTVJgULCBBBH?=
 =?us-ascii?Q?KMxavDXtiFZCl92PEmGTlyNZCm0P12+SmJNi0ZF16g5eE5qFcDHon68qC/uS?=
 =?us-ascii?Q?xi1HAeQmbIWwyj1iuNR5JnD6V56NwAnEZGYzzcLbsETOgkgJa4Uk1Yzu3XgV?=
 =?us-ascii?Q?MAe8l2fd4AHyDp5adtk1bntwEyBoJRaKf8jAogcAJB6UY5Kn9tGDD/4gCRtL?=
 =?us-ascii?Q?m1Q3vd8Qqmmmc3f6DPIvALJPWDE7zIeRcxmTwVEUAFZTPZNp01DzuOikAiM9?=
 =?us-ascii?Q?Br1n6cLNs+Gt6/vxOPqKPmOhyqqGHd0lyF9nOP8dS5qRvSdkvmlzpe9Qi7l2?=
 =?us-ascii?Q?w8feVRg2CU1zCNKMj/JXq//e7/74Rb5AEkLkfyTjS56X/PCx0VtBvD5ur45d?=
 =?us-ascii?Q?kIxr6CjVlSN059E2PESQ0HgyEcoi8INaOq50G9xAHVV/UVlGIDDgQ0DrFNIJ?=
 =?us-ascii?Q?L2mIjVf5mJGi8zhn43k9Xc2AuZPgZBN4ohuH01Bhtpu3JKO/n7tGGz+kx/A4?=
 =?us-ascii?Q?t2xSbRGy88B5d/RtLFrxUXN2YlI5h18e3IElfn2LXdy4FYGcZXu0D1Yz9sc4?=
 =?us-ascii?Q?L83WjJ9eKAGlRlpFkCjStAkwKG18YvB7856pFfLsXzgO2XNEtp1QaUCzAoZd?=
 =?us-ascii?Q?+j8AE9qgkFD18JDoG28MbCMZIH2pIsFzcyH3t1KWPFiuoOtXfOiUs8lpbHIX?=
 =?us-ascii?Q?5vQl0rZfFM5+10CGvB71ttVWUwzdfe7nE3zWMsyEZv8moNBtbY1Z6/02S6wB?=
 =?us-ascii?Q?cxg9l6DGp4A0mb/mzz59JXbxk9yotvKULqX9rcLkxtQs+pqO+2MLnbJ8b/PF?=
 =?us-ascii?Q?3tEH5fliDcOGLIUQKHwK8w5OhB15gCErEgbSJWotkSTjGAuLL7llfFXme/un?=
 =?us-ascii?Q?f1DLhaHAXCWn2G8GTnqGxKjN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f47d3c8-2074-4508-9446-08d967f6caaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2021 18:33:10.7809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q3bK1sCLylyhFdfZdHbyqAOV14TQ7iGOF9VEPwAFPhdy7utLpx/SvRj3PhFBKf8vj2DqbMDlNHXXAOz4yNGcuDveV5NZrk7+e4uUS52FiAc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR21MB1313
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Wednesday, August 25, 20=
21 6:39 AM
>=20
> Commit adae1e931acd ("Drivers: hv: vmbus: Copy packets sent by Hyper-V ou=
t
> of the ring buffer") introduced a notion of maximum packet size and for
> KVM and FCOPY drivers set it to the length of the receive buffer. VSS
> driver wasn't updated, this means that the maximum packet size is now
> VMBUS_DEFAULT_MAX_PKT_SIZE (4k). Apparently, this is not enough. I'm
> observing a packet of 6304 bytes which is being truncated to 4096. When
> VSS driver tries to read next packet from ring buffer it starts from the
> wrong offset and receives garbage.
>=20
> Set the maximum packet size to 'HV_HYP_PAGE_SIZE * 2' in VSS driver. This
> matches the length of the receive buffer and is in line with other utils
> drivers.
>=20
> Fixes: adae1e931acd ("Drivers: hv: vmbus: Copy packets sent by Hyper-V ou=
t of the ring buffer")
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  drivers/hv/hv_snapshot.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/hv/hv_snapshot.c b/drivers/hv/hv_snapshot.c
> index 2267bd4c3472..6018b9d1b1fb 100644
> --- a/drivers/hv/hv_snapshot.c
> +++ b/drivers/hv/hv_snapshot.c
> @@ -375,6 +375,7 @@ hv_vss_init(struct hv_util_service *srv)
>  	}
>  	recv_buffer =3D srv->recv_buffer;
>  	vss_transaction.recv_channel =3D srv->channel;
> +	vss_transaction.recv_channel->max_pkt_size =3D HV_HYP_PAGE_SIZE * 2;
>=20
>  	/*
>  	 * When this driver loads, the user level daemon that
> --
> 2.31.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
