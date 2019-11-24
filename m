Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A74F510852C
	for <lists+linux-hyperv@lfdr.de>; Sun, 24 Nov 2019 22:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfKXVwc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 24 Nov 2019 16:52:32 -0500
Received: from mail-eopbgr720105.outbound.protection.outlook.com ([40.107.72.105]:28499
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726855AbfKXVwb (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 24 Nov 2019 16:52:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bp/yq5QH+XRt7Qrh9jen71H9oE7UZGUIKsETb9zaWdPbnQEKOm3RsEozY9erB7f4LIGYEFL+Xt6KvVl5ShIdJ0zF00YWnFVRidvvQReAcCMHHnYoB2dbrJ49WpeEr9gYVLExUK46CuVZOdlvhu4AmKH6LwXb/ZkL8NVK8mg8j+iuneZhD0TR3I6wKpyPQkuIXVSnnP889eW1PwbYiQCYrNRKWRQBd/O78/iYaDL8b3p9oP8flqhwHtEZA5sovXd0gkPO7nTQergvWQTNYEzmZjLbzuadzSa6W87l48CGPTOajEXHA0RtH6h0jnKcR+zEX3Z3OooCAgm2zoOdY83CkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOAtM2/SEg8HdqiTq8Ww+22ANNC347xijF59QZaUXrQ=;
 b=eGsxB/BclSu1UIkbRwJS5xra60Q5krGYy6mNEkCEWThRrB74WTlq24CsQM/Ab1YZpcR/GarK1FtR0ipZJgUrXKaTYULQagYAjYC36n6qVH1dPLho0T5ocgr0IV492ShA6kA42LbMsX3MlMMSyk1YsivXHlnS1PJ5+XvJ5QrwAHqpw8UqxNW90ZQEwTemyBlwGtO2RlQ7JXTD1rabWciR8kBwVndgQ09yGLjRJklYV8CvGRjFvrCUlrM34v4QZknhxXzLgJNOALa0ecagkvbRyJcVwm8J2QlFM1BHGWHCBwAHlkACMIFgMeZrk5CKzdoJ5odvJ8ZSiDc+6RYbWdq93g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOAtM2/SEg8HdqiTq8Ww+22ANNC347xijF59QZaUXrQ=;
 b=X22NuIK/9Z7v3CV4pDPkB0wEMD7WG0vYZlu2MykJy7zquYeHZGvZUSnoj9mRD/G0HbKXxCWxg7O/kjxVG8fHKivLtjHGzGmmi1nM3jxe+/6Ta2xZFxIte/BKrz3RlAIchI6ZKmz33O8Mw80vxiCQv9W75LyKph/Atf/vJsImURc=
Received: from CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) by
 CY4PR21MB0853.namprd21.prod.outlook.com (10.173.192.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.0; Sun, 24 Nov 2019 21:52:25 +0000
Received: from CY4PR21MB0629.namprd21.prod.outlook.com
 ([fe80::ed94:4b6d:5371:285c]) by CY4PR21MB0629.namprd21.prod.outlook.com
 ([fe80::ed94:4b6d:5371:285c%4]) with mapi id 15.20.2516.000; Sun, 24 Nov 2019
 21:52:25 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: RE: [PATCH v2 4/4] PCI: hv: kmemleak: Track the page allocations for
 struct hv_pcibus_device
Thread-Topic: [PATCH v2 4/4] PCI: hv: kmemleak: Track the page allocations for
 struct hv_pcibus_device
Thread-Index: AQHVn3KNwdoS2tKMykqOFKpvSqwiR6ea4AGw
Date:   Sun, 24 Nov 2019 21:52:25 +0000
Message-ID: <CY4PR21MB06291A46E770BC209DA4970AD74B0@CY4PR21MB0629.namprd21.prod.outlook.com>
References: <1574234218-49195-1-git-send-email-decui@microsoft.com>
 <1574234218-49195-5-git-send-email-decui@microsoft.com>
In-Reply-To: <1574234218-49195-5-git-send-email-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-11-24T21:52:22.9754660Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3f081ab3-6b5a-4079-ab81-6b195a4d9709;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2f756eae-84d0-4768-7814-08d7712897db
x-ms-traffictypediagnostic: CY4PR21MB0853:|CY4PR21MB0853:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR21MB08533EF395B7757B57367370D74B0@CY4PR21MB0853.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 02318D10FB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(366004)(376002)(136003)(189003)(199004)(8936002)(33656002)(14454004)(8990500004)(186003)(2201001)(7736002)(25786009)(446003)(74316002)(55016002)(9686003)(71200400001)(2906002)(66476007)(305945005)(6506007)(6116002)(10290500003)(66556008)(64756008)(66446008)(478600001)(66946007)(71190400001)(14444005)(6436002)(76116006)(256004)(99286004)(7696005)(102836004)(11346002)(6246003)(5660300002)(229853002)(26005)(76176011)(81166006)(6636002)(86362001)(316002)(8676002)(110136005)(10090500001)(66066001)(52536014)(81156014)(22452003)(3846002)(1511001)(2501003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0853;H:CY4PR21MB0629.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?us-ascii?Q?cNIxAY8Sduwn1H9EP5yC7gDh42xgPKigDmszrn4Suh+7NsKRq3t5D76gx/aE?=
 =?us-ascii?Q?EZZzNU95oMFuVexgtgVO8U1GoSNU63ldtkfuIEulaFZ6zsn6vSYrhUwXnlay?=
 =?us-ascii?Q?SQthoFXJNqyZq3VT36+h8Jf/it0dnp11WI/Vq2AMqxiiB3bfJs7pn+4UYqFJ?=
 =?us-ascii?Q?W3iV4i2LGgpdMxlT4A+/pKdfMRH9QWTiD4NYY9tILO1wyMY4B4CCFo3xvCPu?=
 =?us-ascii?Q?13tQqnhiOKD2VzYPN4X1jExu3eOd2aMw7MECcXo79QGgJr8xL2QdMNAdXjg8?=
 =?us-ascii?Q?VSG7NXP5I79GaeeM8RXdm5GrpCb0p6XGM8RC8oyDwR1k6lmr/MMb6fS0IZl/?=
 =?us-ascii?Q?IFnOera+OEjE6Joa9E0AXucCKHsPeNl1ahK3jjmGRCc5s6kYhIbWsspvXgff?=
 =?us-ascii?Q?56VgDA42Zwf9Lq/CZWz3Zbgf1QWLm3e1q4/IhX6I2wmrkJfbTksTRAhX2d0S?=
 =?us-ascii?Q?5yul3YsjBpvSJ9Jh7Wuf8scIYnU/8yc5/K2NPka7DjoUcn+vpe7IYgP50tA/?=
 =?us-ascii?Q?V8VPHOd07WbOjbFVTPw03/tRLyjVXDv8LvyYXUYKBLEYKrtOFPKDtNv2EJwD?=
 =?us-ascii?Q?owCBlo9d6GsBzKSSw+CL9tQtrNBiNBqql262BOGEl7TCKyZ9TK/0td0EVAUJ?=
 =?us-ascii?Q?xscJYYhNcqlhuFp9r9FhLVXfFZTR9fX0czbdnWsItlzldUq4G1MFMQmflN97?=
 =?us-ascii?Q?EOhtIBKXsXzyrcJBBaMl1v8jH2wqVG//eaWV8WB+OktaOZxceWc/gu8p1qJa?=
 =?us-ascii?Q?YanlEY7/Liz2ukkx1cmh5cc+g7d2xvSStYZV8reKkP2D1V0J4rkSevYU+rL6?=
 =?us-ascii?Q?Zw5eOzPlfLdooiBIPBoC7ED3cZVLpiFOdjUO/gf/B92RujVXQUU7slUwnuo+?=
 =?us-ascii?Q?kMaiqdmVzGM0uKkG4UqqGzv602X3oAwldfcQa8+/1VKizIDKaf5rW7DzXsdo?=
 =?us-ascii?Q?lsHYUsJ2GtHm9FJj1+/d1kku14RYdOPQzHQYdnqtqZxlGHjFAuUVdvApYP8y?=
 =?us-ascii?Q?xJRdhFCXKQieZ1NRJTj6mIzxUaNAVlHo8M3TXIITw6GrQfJbZfMDptlJG77j?=
 =?us-ascii?Q?uTDk7WqL2nXdtdJTR759iUD14T/V2Mb5Njl6bbnhWOiA4j5skvTDqNHADX9f?=
 =?us-ascii?Q?1W2yhXRhlyLtxXY+lMO11nCVBS/hY3ZBwYDgorBOTgSQggVNJgzyGFsNaOzJ?=
 =?us-ascii?Q?wWRkzoNTeLvhDN2k2UMuLsxLIRPok5LuyTof1bviLFAEAJfjzaeepfearnJO?=
 =?us-ascii?Q?jm4PIaEhutQbHESbAMilrRkwMHV1k907QG6XIjq2xbrawxElMasMNCb9W4Gp?=
 =?us-ascii?Q?+Nx4S2cgbc6YDJv5sppvh4WckJwYCHAlLkkzVJVZ/X17oJ94WxE4JkcFn7sE?=
 =?us-ascii?Q?Jvo/Gt5ZPoB2IJUO87WcH0WjwYGRjYliAnDaDg8QRAsR/dn0P9bEyPepAOJr?=
 =?us-ascii?Q?h9zO2XTOGcKz2Qr8oRjh6UKTYo5k0y1AWySAbxUru+eYk1W0oYOGZ0UzrXZU?=
 =?us-ascii?Q?gn+A/keJBE4hUTIi2WdWljw2g8UXUexcozf5HrPMBtOI5ZnQ1qsQXUZMkiNc?=
 =?us-ascii?Q?pKygrr3tMOY3nvW7iYlCZX+8UaRyehc7lQTeemNFIirghL/IuQakvUaGxyul?=
 =?us-ascii?Q?qguFfT+bgqmCI8smxmxCeZ3USJowFojcfPwLFp/ntxNgiIq7fZhVIaWfr7yh?=
 =?us-ascii?Q?QnrjxmDvSNRB551gXF44+bvdO44mhalKKN4IMXC9hIUrMwM/wJyas1AXIYUB?=
 =?us-ascii?Q?r+Sn8BRs5M8zfgH0SxWSqOT5hZTJKOww6+4DjT1VZkC56FTASx3fyOOOb1bO?=
 =?us-ascii?Q?buX3uyW9fRLM4/6D82mQfLnOATFcKsB2vHT2h5BrLfDoA58YWnDjs0ztRIqs?=
 =?us-ascii?Q?9ryMh0LVCRc9QGGCj4rw19EiRY79me8FVNyHliRTMlVXhn3X3BMUQ48FOovG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f756eae-84d0-4768-7814-08d7712897db
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2019 21:52:25.2699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q3LDkYoF/uLLkMq18x0R++4vUw9l4Gmg3oG1jCrh+TbDebtu58n7QImtoSKqL7wG/jxEIHkfmgheWBR6z5xKFmSCObh5S8r/ef5UH/yTdeo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0853
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Tuesday, November 19, 2019 11:=
17 PM
>=20
> The page allocated for struct hv_pcibus_device contains pointers to other
> slab allocations in new_pcichild_device(). Since kmemleak does not track
> and scan page allocations, the slab objects will be reported as leaks
> (false positives). Use the kmemleak APIs to allow tracking of such pages.
>=20
> Reported-by: Lili Deng <v-lide@microsoft.com>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>=20
> This is actually v1. I use "v2" in the Subject just to be consistent with
> the other patches in the patchset.
>=20
> Without the patch, we can see the below warning in dmesg, if kmemleak is
> enabled:
>=20
> kmemleak: 1 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
>=20
> and "cat /sys/kernel/debug/kmemleak" shows:
>=20
> unreferenced object 0xffff9217d1f2bec0 (size 192):
>   comm "kworker/u256:7", pid 100821, jiffies 4501481057 (age 61409.997s)
>   hex dump (first 32 bytes):
>     a8 60 b1 63 17 92 ff ff a8 60 b1 63 17 92 ff ff  .`.c.....`.c....
>     02 00 00 00 00 00 00 00 80 92 cd 61 17 92 ff ff  ...........a....
>   backtrace:
>     [<0000000006f7ae93>] pci_devices_present_work+0x326/0x5e0 [pci_hyperv=
]
>     [<00000000278eb88a>] process_one_work+0x15f/0x360
>     [<00000000c59501e6>] worker_thread+0x49/0x3c0
>     [<000000000a0a7a94>] kthread+0xf8/0x130
> [<000000007075c2e7>] ret_from_fork+0x35/0x40
>=20
>  drivers/pci/controller/pci-hyperv.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index d7e05d436b5e..cc73f49c9e03 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -46,6 +46,7 @@
>  #include <asm/irqdomain.h>
>  #include <asm/apic.h>
>  #include <linux/irq.h>
> +#include <linux/kmemleak.h>
>  #include <linux/msi.h>
>  #include <linux/hyperv.h>
>  #include <linux/refcount.h>
> @@ -2907,6 +2908,16 @@ static int hv_pci_probe(struct hv_device *hdev,
>  	hbus =3D (struct hv_pcibus_device *)get_zeroed_page(GFP_KERNEL);
>  	if (!hbus)
>  		return -ENOMEM;
> +
> +	/*
> +	 * kmemleak doesn't track page allocations as they are not commonly
> +	 * used for kernel data structures, but here hbus->children indeed
> +	 * contains pointers to hv_pci_dev structs, which are dynamically
> +	 * created in new_pcichild_device(). Allow kmemleak to scan the page
> +	 * so we don't get a false warning of memory leak.
> +	 */
> +	kmemleak_alloc(hbus, PAGE_SIZE, 1, GFP_KERNEL);
> +

As noted in the existing comments, the hbus data structure must not cross
a page boundary, so that a portion of it can be used as a hypercall argumen=
t.
Historically kzalloc() didn't provide any alignment guarantee, so
get_zeroed_page() is used.  But a recent commit (59bb47985c1d) changes
the behavior of kmalloc()/kzalloc() so that alignment *is* guaranteed for
power of 2 allocation sizes.  With this change, the better fix is to use
kzalloc() instead of get_zeroed_page().  Note that the allocation size shou=
ld
be HV_HYP_PAGE_SIZE instead of PAGE_SIZE, as the hbus structure must not
cross a page boundary based on Hyper-V's concept of a page, which may be
different from the guest page size on some architectures.

Michael

>  	hbus->state =3D hv_pcibus_init;
>=20
>  	/*
> @@ -3133,6 +3144,8 @@ static int hv_pci_remove(struct hv_device *hdev)
>=20
>  	hv_put_dom_num(hbus->sysdata.domain);
>=20
> +	/* Remove kmemleak object previously allocated in hv_pci_probe() */
> +	kmemleak_free(hbus);
>  	free_page((unsigned long)hbus);
>  	return ret;
>  }
> --
> 2.19.1

