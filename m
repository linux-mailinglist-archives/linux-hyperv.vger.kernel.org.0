Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F13401DEF64
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 May 2020 20:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730895AbgEVSlQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 22 May 2020 14:41:16 -0400
Received: from mail-mw2nam10on2136.outbound.protection.outlook.com ([40.107.94.136]:56121
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730829AbgEVSlP (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 22 May 2020 14:41:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AyaOBiY0Vtmy6uFY9GFPtEqGQDANlxuiPaZXY0PTgvh4E7iKyq/1ArB3ayeyrZDFGiFgTKz11cdJCndUhPaUVNjyY+ViU7c+oGQkeslt7SVA/bGZrd9wv1YoOp3zYhXLXnPmx6CxgjIjX3HLD9/jhTaFEf3/Q0iVEolQ0B7/HQtbxj0SjHUCfRMK8xQgepvRHv/dOP6ex8QBuY0yGpgZBH5VCa9m+0CYyQuQnGgI+/jWR+mdt7C+9iB8OGln1FmSmaFY+wlyK7DN5mUBjqLLmC0jwWj8t0coDKl9YbqodelA6Jf9txrZzKxdQ0Uh+dPDi3RKFJFQb7Da8QayI4/Ddg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIZtml+JOUlFxr7NoqRvl3dHqhEb9ElJ+jrgQfy14QU=;
 b=dAt0wUBBr0PqMbpJYnaGqxpFg+Hz5lxf1+zurmTPxoWDA/7tewc0G3pMASBXhRyM6GMnWrzi8ziTmCQGLxjw6S5wowYgM10k4aTKUjixmAPOVScpT8aa92GZm77iVIFoPmjSeHtRWWQ6199x6331+R893X3QtjHsckR0kedKhzj5KqR49CeERZk+feUGc8LOu97giiwp4I9831DzPo0VDteRqs/JvhuIHq0+AV2AvKLdl34faRYLXZNT2nhja5Ljuxttnx1KOVfM6TQjQyrhpBkslNwAlWwwNl0cpzidAXcoG/lXcBToeNgtWMBb6+5xA4ZPT88pTiscS5QMEiHVTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIZtml+JOUlFxr7NoqRvl3dHqhEb9ElJ+jrgQfy14QU=;
 b=hbuRMXs4naCRBEzhklLbjudwTs/p6w+cSej/J/DKfqsa+K2klU6P614IX+7FAqmcmCQbSG697WoCwQKD4SMOzrJFhfPydM1KSMyhTusH9/j1j+Oh2zMuzJEyKZbM5T49jicz8YqW3+8c3apyS13rKhWQv94WV7Xg1uGLf8bAQmU=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB0923.namprd21.prod.outlook.com (2603:10b6:302:10::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.9; Fri, 22 May
 2020 18:41:13 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::5a3:a5e0:1e3c:e950]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::5a3:a5e0:1e3c:e950%7]) with mapi id 15.20.3021.002; Fri, 22 May 2020
 18:41:13 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: RE: [PATCH 2/2] Drivers: hv: vmbus: Resolve more races involving
 init_vp_index()
Thread-Topic: [PATCH 2/2] Drivers: hv: vmbus: Resolve more races involving
 init_vp_index()
Thread-Index: AQHWMF1AqQ3jESdKyEKGe2bznL+fZai0cBRw
Date:   Fri, 22 May 2020 18:41:13 +0000
Message-ID: <MW2PR2101MB1052D20DE7775A1653145020D7B40@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200522171901.204127-1-parri.andrea@gmail.com>
 <20200522171901.204127-3-parri.andrea@gmail.com>
In-Reply-To: <20200522171901.204127-3-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-05-22T18:41:10Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7bcaa77b-266e-433c-a6f4-2ccd8f208173;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 378874fc-d582-416d-8d30-08d7fe7fb44e
x-ms-traffictypediagnostic: MW2PR2101MB0923:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB0923FA6C6F9862DC26B417CBD7B40@MW2PR2101MB0923.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 04111BAC64
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /UJf4DL80UO4QJaiNUIlAS7Aig4l4F+rWkQk8ZQw6y2aiEQoDLWnTD/C5mnLLgvTKU1VZ0BBDxgHdA2nCwf6hHaI0jp9uNfM7XOYOM76ALVEbXCkVVRbHEbi0+2JvJKsgRzeBlnAqzuvWyagje/aYMtcEwVxOAB3ZCAIMaBr3fmV+y4clEgS5oieLGruoPkVxt2mBVrBweERRRLvJmz70GjkxffyrYvRprJ4eh6woS7gNgpuR2jH3zpbXU+zcrDTaEm6EhsVLpDkrnfc33llt8V+Jp7zZV8DLDHoOpU8gvc2vUE7tquzhI1UJRMHXQGtbv33gPBxAk9QRsBh6gLTyA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(186003)(76116006)(82950400001)(52536014)(8676002)(82960400001)(9686003)(66446008)(86362001)(66476007)(66946007)(5660300002)(66556008)(64756008)(26005)(10290500003)(71200400001)(33656002)(8990500004)(8936002)(478600001)(55016002)(7696005)(2906002)(316002)(4326008)(54906003)(110136005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: /mmlnIn3ZxsRGxKyu4yViZ/s/RnZ4nScYk4ZbqRYZGHTu6B+TOzCkVgbHWIBPuZlogWCy+i6Bb55a5wiZmxcW+RQXotUKwBReh9S4wFvRsjghAhYM8Ov0gtG8rfd46yJZscdeMsbtAMhpI6r7g9OC3clMW0pVDRF+eItkZJ9J7EtI6qljH1TuHjJVf7/LfBepKVlQdgtByL9AdbXdL09QMvvvtrKXuVRXF3uUVgbU4xnFEppyisUiCXrpjMsLTOxMUra7Koexca8H3XHn0dE57jq8LG0PR9LmBjPf4GqCQcRVx0dYEFHHGucU4u8kudxSSjmEvEY5vYcVl244BJd0Y7ex89cXMCRh9JD0X3i3IyFh7XPDI8LW967td8AyNSTlvbDhZrEUUFhibv23HcsI/1IH5bvuhD1vF+q5z+bFciL+ydLhILulSMNjjaFiukbrAyTqElbJLtpDp8xo890TSku+dUoycleRCt7w28gVPD0Jdx4WsM0nTQOcyma9snF
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 378874fc-d582-416d-8d30-08d7fe7fb44e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2020 18:41:13.4133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Irep7DFyHhQAAlrVECBZjHHzLSap7vkESUO8X2D/+m5oCEIQM+IoKex49lcYGVVSHSCINhgzSXUDWkMC6p4dAtwjSZpFqiajVTDpe1sBHbE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0923
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
>=20
> init_vp_index() uses the (per-node) hv_numa_map[] masks to record the
> CPUs allocated for channel interrupts at a given time, and distribute
> the performance-critical channels across the available CPUs: in part.,
> the mask of "candidate" target CPUs in a given NUMA node, for a newly
> offered channel, is determined by XOR-ing the node's CPU mask and the
> node's hv_numa_map.  This operation/mechanism assumes that no offline
> CPUs is set in the hv_numa_map mask, an assumption that does not hold
> since such mask is currently not updated when a channel is removed or
> assigned to a different CPU.
>=20
> To address the issues described above, this adds hooks in the channel
> removal path (hv_process_channel_removal()) and in target_cpu_store()
> in order to clear, resp. to update, the hv_numa_map[] masks as needed.
> This also adds a (missed) update of the masks in init_vp_index() (cf.,
> e.g., the memory-allocation failure path in this function).
>=20
> Like in the case of init_vp_index(), such hooks require to determine
> if the given channel is performance critical.  init_vp_index() does
> this by parsing the channel's offer, it can not rely on the device
> data structure (device_obj) to retrieve such information because the
> device data structure has not been allocated/linked with the channel
> by the time that init_vp_index() executes.  A similar situation may
> hold in hv_is_alloced_cpu() (defined below); the adopted approach is
> to "cache" the device type of the channel, as computed by parsing the
> channel's offer, in the channel structure itself.
>=20
> Fixes: 7527810573436f ("Drivers: hv: vmbus: Introduce the
> CHANNELMSG_MODIFYCHANNEL message type")
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
>  drivers/hv/channel_mgmt.c | 22 +++++++++++++-----
>  drivers/hv/hyperv_vmbus.h | 48 +++++++++++++++++++++++++++++++++++++++
>  drivers/hv/vmbus_drv.c    | 19 +++++++++++-----
>  include/linux/hyperv.h    |  7 ++++++
>  4 files changed, 84 insertions(+), 12 deletions(-)

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
