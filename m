Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1F63FF217
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Sep 2021 19:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346506AbhIBRKR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 2 Sep 2021 13:10:17 -0400
Received: from mail-oln040093003001.outbound.protection.outlook.com ([40.93.3.1]:15843
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1346439AbhIBRKK (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 2 Sep 2021 13:10:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fxb/M4hM0SQkLVKxF4TXDQvOAfBTqygc4e3dnQ8FdYUd6crN2K0c98qZ4yJXqmVau4fyYyLQ1iXNTOBqJD/dYeztGntdG64kLExJKeLZk/c8owkpug9zw5ALXeQdSV01zJn1vBXpjSGoy1YweG5kIiI+vxJ83tOH0zHN+TTQoWToyjl4hEhWTc9aFIVAc5cQCCHRLfNJgEzkGZlsGy+5Vb839UgOl4icTcDCXKCqvwR/jbpnGR+jtS8DevwLhcVJ/WINulMYit9tJFGMN/fFW9+pvy04rKjka4UnwqzSW1wmMZE4X5Lg041j34brhxYdj7B00UEOSMwzD6bjEhowTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=App+wzsdC0GHd8SzxfDAKWZNXFQ96wrRfTSa0JEZ+mk=;
 b=AL4xZ62wcQhp4USs6rwn6Y/qJgJJHhHpyjpUZV3r4iyVj4DZHEUhHwUn8Tze6i29QkPdiLKa/+AoKztCpYZcnKBw+RLEBVGJgQ5mvOKFHSS8qoZnb+4frhrQ9k/8mpJW0PKQfinAFhQonkj7+bH9e6lpEz+Xa1GrH5dVfvQjIjCCGN+DoYVa+Ffz3+/tHUU6C+nBUgc14gYdNEmZcNuZDSGfIeq9etkFwhM9aaf12LgQPNOpZwqLh3PiIQKygskdyRFPtm4DEtnSVKbpTKFW8cFxyhi2EqBes3jhIokCN8StKt2UBBZCAXIJu5cxQo/gM+CDJCN4zy62VoiJmnOC7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=App+wzsdC0GHd8SzxfDAKWZNXFQ96wrRfTSa0JEZ+mk=;
 b=Tizxtsmhk0pnMySybIuA2NyoeC2P+ASatIHCEVrQkQY2G4UM9EF9jPDCE/RKh8063Ljd/zq9kzBZ3Q8/J7qVDdbrYVuI3e+AQqjkn1LpBmSr5DdlrOA4ye0TQ2gUrAfkFtp6J2IR2c08n4E/RQ++zqBdchqgxE8clV8p/dXbDx0=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW4PR21MB2041.namprd21.prod.outlook.com (2603:10b6:303:11c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.6; Thu, 2 Sep
 2021 17:09:09 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::3c8b:6387:cd5:7d86]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::3c8b:6387:cd5:7d86%8]) with mapi id 15.20.4478.014; Thu, 2 Sep 2021
 17:09:08 +0000
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
Subject: RE: [PATCH] Drivers: hv: vmbus: Fix kernel crash upon unbinding a
 device from uio_hv_generic driver
Thread-Topic: [PATCH] Drivers: hv: vmbus: Fix kernel crash upon unbinding a
 device from uio_hv_generic driver
Thread-Index: AQHXnnYBTI4PTSpBKkqF5K5fFbYk7KuQ/Vyg
Date:   Thu, 2 Sep 2021 17:09:08 +0000
Message-ID: <MWHPR21MB1593E659BCDB87B452687CC6D7CE9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210831143916.144983-1-vkuznets@redhat.com>
In-Reply-To: <20210831143916.144983-1-vkuznets@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=35c05d14-4c0e-4aa8-9af9-3f7db01f8edc;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-09-02T17:08:25Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 493de44d-2ebe-473f-a463-08d96e3460b3
x-ms-traffictypediagnostic: MW4PR21MB2041:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW4PR21MB204187FEDE78F30CFB3F2DEBD7CE9@MW4PR21MB2041.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sQ7BvumtH/o2N6olnhuUYCitBQPJDC3PYDG/odBK9WzawQtUdApgPjySbR8YCvcGLIPx0IUPwYD8yoP2AsM5iKPRp/dRk+IzEzJtoEym2gGXYsf225RfjJ76R/aB8aAQIZ/9ZbuylIjALKrM4buG4OVQWez7EqQMrdxTxP0MMZkUkuSpr8QY8A3WfGLvKndUHYJyuEKhGKqfa+c3SDyjywr9WrZoVCc2IVLFc+HlL6eLQsyQQoNPtNb/Zwa81A/UWqo4TQ7xudY+TcOxhTUvHhZBRA3W5BHcZJj6AcGStjr6e4D+kBluxgFx4pr4KucQI0R/BcUqTgk18fWxMaPnLEozY6NpVdBPfaXIPCA+oP8mCgVZvzFu1hzJ8A0w4ic6zaYy/0ITz0lzvjq3NLQ3mx4hnvcjX6yystVahkp4qNAhCeegjOkl4wrfS8U0fDeS77htI4uyrvWdYNSptysvm5FvhJI+hVgao/ixIJ4YYQdtRLfqvq6ov86liGmMj2cNJ9WAhZa7pvuSRQEmgukPamTL1j2tLv4HXPhYgWEZ2pueEcwOQsqYje1cbMHE5CdHS9X3jcIHxopueoa7EAf0vpda929nM6r7JjU2HYQAHrW+vcbqGDcLB4xsugLbDJNrWFIGOdnXSpZ/laYd9TZDddm54VdDZU6O8MPZ8U9Fa7v6AGn6+kWTBAHD6324lBbzjs0GYmRVH3lJzXE0w+KbAxxRGeI1g3+lQ6Yc/bSuZeU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66446008)(66476007)(66556008)(8676002)(64756008)(76116006)(66946007)(82950400001)(83380400001)(71200400001)(10290500003)(82960400001)(8990500004)(9686003)(52536014)(5660300002)(26005)(508600001)(4326008)(186003)(38100700002)(55016002)(8936002)(86362001)(33656002)(6506007)(54906003)(38070700005)(2906002)(7696005)(122000001)(110136005)(316002)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QSkXyNj6eWV7SjKxw8bz/LeSNhONNegjgd8hB2Raele7ESJ5PVnP6fW3nXNA?=
 =?us-ascii?Q?wROsGrwTffmwbJ+KM8+LCbScfXEZS5z6DgrvEBKfcYC8lCj/KtmdRXq1vXyb?=
 =?us-ascii?Q?iD3TsAdZBXUR7FpIy4UeaN4lYtfuj0qd2+igut4x3gotjfZPA0rrbOKGSvqh?=
 =?us-ascii?Q?CvFWhjb43gOPgBx22qfdmMG5IIavtyXWUxMsVbk5iZqbN0x7t3o7Vyu+M2t5?=
 =?us-ascii?Q?qOfCFdflBETE3mR85OOShBQCf5y/8dzv9+u9JRyKvpdZug6j9pjL3tCu0vwM?=
 =?us-ascii?Q?+PsNYuDj1RJ1glmJzYNWylJC8CszFT7XKoWBzXA4pXOi3Faf67g03WKe4iZH?=
 =?us-ascii?Q?IuUcCSehMjp0lMD2YbZvHJkrCcw20iiORKwCig7ekGGPfT9z0Tn8u1QTUevn?=
 =?us-ascii?Q?uFCYk+IwqgGMU+1+n1LzPyegeRbIN0qgEMIL7o//q10NoBpmO3Kel4aDDpUl?=
 =?us-ascii?Q?4eMWz5x8kewXICjc627PheuCPNlOeCMUbJz+SS1ZUBfvAiFfnSV/7W8llNtv?=
 =?us-ascii?Q?kAerresUEM359ysoun+80+1O4ejiuCQJtvn0MnDRW/qvXo6zSGRZbCWt7dqs?=
 =?us-ascii?Q?uNf6T00AqyKvhgmcKuFb/qHKlJ6huNo+WqToAtGQoVejPQw0HRav89VxbInR?=
 =?us-ascii?Q?ksoAvoabn5Itg7gFs50w4ZU2kxgBDfgFCGaJJK0ySAWu+nimYv3PjdxCi5K3?=
 =?us-ascii?Q?CdLKniXFK2ZbqwYWV39K4NIhld7wsT6M9perCqoFUfRD64d6tPxP8N/dFR4N?=
 =?us-ascii?Q?3wVcrfnTqZM/Tcnvt/0+G/7zzlfg7OX04PVouikmTLKVN2UnYwT2vWC5zNpJ?=
 =?us-ascii?Q?FA27GfikyeC8SYx5XL3axLM2MLmnIXRkJmKV8ZL/QarW4qpi37VGwAteoknU?=
 =?us-ascii?Q?62q7g8Qpaz75E5dOoPRH/UYPCnvBSTdKseHYJwr13I+jjESyJaikiawb1TVu?=
 =?us-ascii?Q?FMILt6C1Q9XjjgQ9kusGkubrGKI1UnUe71nB0d6rnwgNKN8409VO4KgODekq?=
 =?us-ascii?Q?Ye/3YApaARyogUF4FIkoJlvGr/HYd7N1GGXNYLl4w0Wf+jeIQzr1miOonT2x?=
 =?us-ascii?Q?0nUcrVRMgwwZDu5NCO2xU4z1aoUWNgjkN3QA76PIDQF5oGqbEr/EjcQoFEYX?=
 =?us-ascii?Q?zRiO6ZdPsrgKJxbkQw9X9pVpPi+re6t95/rQliV7Aesp5BzuLNhpKCUuv2qS?=
 =?us-ascii?Q?IWEQYv9UGsZIxMzYBP/6PFySCq+ZsMbqUt5n5MUig2LmDbJ5ajHiFcaPqF+U?=
 =?us-ascii?Q?Y+peHbA8xfP0vt18g4CTxtH0M8ISACEc1zYl7IqpRZxeZWwbnNRfY2Dqh5/O?=
 =?us-ascii?Q?n7JhIVtJMHXVSylyYeoGMuRd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 493de44d-2ebe-473f-a463-08d96e3460b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2021 17:09:08.7457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uYG8rCUpfcO2II3fDY+0pK1SxvfUJjG+Dt3QLnYWv7nSdizs51YuaKSmLCJjmPf2B/sit1uMk0Z0EGM/eH5uXgk8HLq96oGQVHROW+2244o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB2041
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Tuesday, August 31, 2021=
 7:39 AM
>=20
> The following crash happens when a never-used device is unbound from
> uio_hv_generic driver:
>=20
>  kernel BUG at mm/slub.c:321!
>  invalid opcode: 0000 [#1] SMP PTI
>  CPU: 0 PID: 4001 Comm: bash Kdump: loaded Tainted: G               X ---=
------ ---  5.14.0-0.rc2.23.el9.x86_64 #1
>  Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BI=
OS 090008  12/07/2018
>  RIP: 0010:__slab_free+0x1d5/0x3d0
> ...
>  Call Trace:
>   ? pick_next_task_fair+0x18e/0x3b0
>   ? __cond_resched+0x16/0x40
>   ? vunmap_pmd_range.isra.0+0x154/0x1c0
>   ? __vunmap+0x22d/0x290
>   ? hv_ringbuffer_cleanup+0x36/0x40 [hv_vmbus]
>   kfree+0x331/0x380
>   ? hv_uio_remove+0x43/0x60 [uio_hv_generic]
>   hv_ringbuffer_cleanup+0x36/0x40 [hv_vmbus]
>   vmbus_free_ring+0x21/0x60 [hv_vmbus]
>   hv_uio_remove+0x4f/0x60 [uio_hv_generic]
>   vmbus_remove+0x23/0x30 [hv_vmbus]
>   __device_release_driver+0x17a/0x230
>   device_driver_detach+0x3c/0xa0
>   unbind_store+0x113/0x130
> ...
>=20
> The problem appears to be that we free 'ring_info->pkt_buffer' twice:
> first, when the device is unbound from in-kernel driver (netvsc in this
> case) and second from hv_uio_remove(). Normally, ring buffer is supposed
> to be re-initialized from hv_uio_open() but this happens when UIO device
> is being opened and this is not guaranteed to happen.
>=20
> Generally, it is OK to call hv_ringbuffer_cleanup() twice for the same
> channel (which is being handed over between in-kernel drivers and UIO) ev=
en
> if we didn't call hv_ringbuffer_init() in between. We, however, need to
> avoid kfree() call for an already freed pointer.
>=20
> Fixes: adae1e931acd ("Drivers: hv: vmbus: Copy packets sent by Hyper-V ou=
t of the ring buffer")
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  drivers/hv/ring_buffer.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
> index 2aee356840a2..314015d9e912 100644
> --- a/drivers/hv/ring_buffer.c
> +++ b/drivers/hv/ring_buffer.c
> @@ -245,6 +245,7 @@ void hv_ringbuffer_cleanup(struct hv_ring_buffer_info=
 *ring_info)
>  	mutex_unlock(&ring_info->ring_buffer_mutex);
>=20
>  	kfree(ring_info->pkt_buffer);
> +	ring_info->pkt_buffer =3D NULL;
>  	ring_info->pkt_buffer_size =3D 0;
>  }
>=20
> --
> 2.31.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

