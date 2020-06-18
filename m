Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A788C1FF697
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Jun 2020 17:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbgFRP01 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 18 Jun 2020 11:26:27 -0400
Received: from mail-eopbgr770107.outbound.protection.outlook.com ([40.107.77.107]:52806
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727841AbgFRP01 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 18 Jun 2020 11:26:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OvZkVvTWw1itMMI8ZGT3hFF8k49I2twjoDBvcick4MqoHxLq2kSurKowPiHc/6N7nkwhqicvKpRtnQ5KskxWmg5hlUC9yh1JRk1R2ebhbsgDrqpLaU4Pevj/VAafdTyv1eifvh/ggrvY6KcQlHFwCP+4A9HxDBg8y2HqQnQgfAmg0W4zneO7klYPK0wc74GLlIDiOHLXq8AZjzcauOZyLbYrH4L/5ydi+zNj9ONIRiyn5z6SVRrPsbwVVBZ4U7LqQ75wB9BLkb9bxAuH3gKH64L6G8TtL/fKW7AyW3mgsl6gzs4zqWptYG4JxfXCR2Kmn+9fxe0pM0oH6EQR8c+nbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1ZVQoBVLA497mHQU/AceieK9wqfH9WcIws+Tmad+pU=;
 b=EuTM1y+EaMkAWX4g4evra+AlazHebGm5k5X5FVpOzZEU5TQyHfK5Msr86+9vSxxfHG6d3aYSg5cPj9G9EVw4EZilIBCNbXsWGEUmEqi4Cj9ozt+wMxpnT0fWeq4qgolNvhX0TetmccaKoJ89ZUBbLV8oHou/eGMyumilAeY2DLT7Fn8UoJhFJaq94m0o1meNMF9fW6cKNZ4ARShGQZqarwTF+JNQuOAXfwRIlPkp+/YK+9e7Qpboe6CZrNX7fx+FjoGWLP6FCtf26cEmAhFZ5RS2ZepZDRgBUpeT1UD9xS20H36RQhQ4mn3Wxlg6kNTwQ1tefylk5VpdxAXXA0Z/Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1ZVQoBVLA497mHQU/AceieK9wqfH9WcIws+Tmad+pU=;
 b=S5mkB68q7gubdzBeARWg/hfDdXLnoM5oNBRXXrQGPNuVKVrBbUTKSoFkqD+/RMKohUCjri2TuKjmQg/+6IpUdswL9yc4NwQYcrNPEAtXwvuIi1Dz65wk5OlzlXkFwIJv5JybdHlWFcsyr9yCnMDah+bbfgi34/3XTbzEdaIzs4E=
Received: from DM5PR2101MB1047.namprd21.prod.outlook.com (2603:10b6:4:9e::16)
 by DM6PR21MB1290.namprd21.prod.outlook.com (2603:10b6:5:170::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.12; Thu, 18 Jun
 2020 15:26:23 +0000
Received: from DM5PR2101MB1047.namprd21.prod.outlook.com
 ([fe80::9583:a05a:e040:2923]) by DM5PR2101MB1047.namprd21.prod.outlook.com
 ([fe80::9583:a05a:e040:2923%7]) with mapi id 15.20.3131.008; Thu, 18 Jun 2020
 15:26:23 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/8] Drivers: hv: vmbus: Remove the numa_node field from
 the vmbus_channel struct
Thread-Topic: [PATCH 2/8] Drivers: hv: vmbus: Remove the numa_node field from
 the vmbus_channel struct
Thread-Index: AQHWRMcMODbmTdsuAkun0jbzKF913ajef3kw
Date:   Thu, 18 Jun 2020 15:26:23 +0000
Message-ID: <DM5PR2101MB1047F193F5236C74C785897ED79B0@DM5PR2101MB1047.namprd21.prod.outlook.com>
References: <20200617164642.37393-1-parri.andrea@gmail.com>
 <20200617164642.37393-3-parri.andrea@gmail.com>
In-Reply-To: <20200617164642.37393-3-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-06-18T15:26:21Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a58d0e80-e671-4834-90eb-aad708742bb7;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: aaf53fc1-c96e-4b40-59e8-08d8139bf595
x-ms-traffictypediagnostic: DM6PR21MB1290:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR21MB129035934EED50606ED559CED79B0@DM6PR21MB1290.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nKUbBox2BJkdhsYjfadRYNY9inJ2kLZjdxW1qtF8r6Xtvi693ooVIvda/8B6rN9HNLrci6h7djfRefQh/9cd78kBAa3++wOcdl2FJT3H4kJa01MeLpOS04I2kytjE9oFSPC4YMMLY2D+vsoAZwzW8YrFakgQi3MgJDAlFo6VFI1h8eT4fJ++4MgZMVy585g0c4dDI9SHbWGfViVVT6aqwiOdaQOMOXX6LaOdaeGsfBnfsMV6T48G+HvM/glkDztX44DgZFfJx3GRUWPVjk14zMPecDRw8SXhEZl75lxS0CRaktb9NX2TzXmMmfwQisz+qfafjl3Bx93lZd4NFYwRkg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR2101MB1047.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(39860400002)(376002)(396003)(136003)(366004)(2906002)(52536014)(5660300002)(33656002)(8936002)(4744005)(66556008)(54906003)(64756008)(66946007)(83380400001)(66446008)(66476007)(55016002)(76116006)(86362001)(110136005)(9686003)(6506007)(82960400001)(82950400001)(71200400001)(478600001)(186003)(4326008)(8990500004)(8676002)(316002)(7696005)(10290500003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: AISdi40fs+9oOg8+2nFLPzqB65W15jfiiaHeKXTyNVDABooSwjYRI0igewYuReI5QifUNZuH6XbP0MZINyaJBedyJw/TmOoiVKXLVh6VvD16Gp4I2R/JE/bbovQbzK/eR8+puHyhugZ4wELsHT+qc9daajbBMWo9WApGBqDl17oNNJyK2bSsp7lXxLuDj//1Km7THBo7Y71bWkt2VQekHzCqC4CCk6hlrjlzKCpMsTPB3DsokRKghvmuJL0DoZOrTvpGyZVE1Ctx1xF+Tmbe/ClJ/zX6IlwEDBLz7N/lygpDZPigCDn6Guaz0RltzaCcWhil40MbT+6GS4N6clc7OqlrA1rgcP7nIfemWnZkhLjCeJldxJgMn2tcxZflKrqHH+QN+1//TQtMffQ+6ettcWX+Ix+pVJy+ub7pwIIxtZkbAfYSamVl9+77Ej0Mo7TkVLa+zQJJFQlKYpLmzFD7Py54Gdzmxefp5CMs16pyLEH9WTu+Eeg4dzpxAgkL7JxG
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR2101MB1047.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaf53fc1-c96e-4b40-59e8-08d8139bf595
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 15:26:23.2527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bNqmxKje35mmtqn0M85eKyhGtvdtcTTowwfe0IzC5TPXP+sBp85Gb8FBrR8S1emGYukkn+nH0DimqKKvWbl/9P+DVpVD6fh5XFK/dwiwi14=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1290
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Wednesday, Ju=
ne 17, 2020 9:47 AM
>=20
> The field is read only in numa_node_show() and it is already stored twice
> (after a call to cpu_to_node()) in target_cpu_store() and init_vp_index()=
;
> there is no need to "cache" its value in the channel data structure.
>=20
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
>  drivers/hv/channel_mgmt.c | 2 --
>  drivers/hv/vmbus_drv.c    | 3 +--
>  include/linux/hyperv.h    | 1 -
>  3 files changed, 1 insertion(+), 5 deletions(-)

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
