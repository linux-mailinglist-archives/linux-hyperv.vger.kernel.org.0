Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6593D1A48E7
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Apr 2020 19:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgDJR3q (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 10 Apr 2020 13:29:46 -0400
Received: from mail-dm6nam10on2107.outbound.protection.outlook.com ([40.107.93.107]:18689
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726641AbgDJR3p (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 10 Apr 2020 13:29:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WUS8r5xSuCvUn0mhatQufGrfy1xtdG4l3gXWiR21KJOpL9mpGX7Gzue+dzJXpYYo2VQcAtx8dQr50L51oJb/jKdbb4V+T+ixdtI3umBNtToB/XEu5HNderv13Fxq9OVKtHhivNef9XJx2T3jrm76xVU0uHZU34zlJdr2qLSZpJtaoOuS+B6mJ1AFX2a4x3Cx5rOhdjxdlocO1mFFnUC12RjAvChvnELe7zMz4fi0TLMQI7a20XIs/1l+iWnqp3/dpRZC0p59hKBEsdtIQSyx8GoEFnT+R8quGGE5LFyDoFjhTCw/JJ0QHDAehn1/0Xp9UcEoPdP2i4G/P5wP0aJ2fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+CefDbwh17OV8S8Awhoq/CtJS6OBUo1LILVDBnDe0Y=;
 b=E7HBckRiglBA6VThJC8SDuq++YGAXK7y3eb43yFhPkj30tAw0My0GNJdyo2anspMwQ+G2J/9Ah5ZFJLIF489oLMRaBSpD4m1RDRLKO2Vm85F5H4w1M/6AMSBB/KrrmdR5We2FG8llT4LAlmIjFQ2Q+okaTOt8h2jtKg2+ZzKUB8tayxbBmoQ7Nb4tirBPA9KIAlGqOsYBBexAohOuDi1uwLdBd+ohguNsQS7bLxWbkjQIqMofqim1rWuzKe9ojFZ9tCYvNlp9L5TwhFo1amPLT9ek05uFIEcZlITCOmxot3qOuOTe8VRQG7/+z5ArcOtmm3Iw+/lgXRT7Jgc2ruW5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+CefDbwh17OV8S8Awhoq/CtJS6OBUo1LILVDBnDe0Y=;
 b=Nf/60qJlLy3fgFNI5FVVEG7L2bOxg6lOctgsXYlO/asrhPwMhJTdohtxzSTt+edEOj2y02m23O8EqrbYfKAzjx7JzEzgjSv/Z3LpyLNa2iI/1XFzzELu2kJCiMU4ZY5IFQfiRzSNHma0w+906lNHTv7CbeW6KtR5Sz8VKmLmbms=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB1050.namprd21.prod.outlook.com (2603:10b6:302:a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.17; Fri, 10 Apr
 2020 17:29:43 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156%9]) with mapi id 15.20.2900.015; Fri, 10 Apr 2020
 17:29:43 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        vkuznets <vkuznets@redhat.com>
Subject: RE: [PATCH 03/11] Drivers: hv: vmbus: Replace the per-CPU channel
 lists with a global array of channels
Thread-Topic: [PATCH 03/11] Drivers: hv: vmbus: Replace the per-CPU channel
 lists with a global array of channels
Thread-Index: AQHWC6iqE6sDRgLYPEmmKtjFGljjoqhyo0CA
Date:   Fri, 10 Apr 2020 17:29:43 +0000
Message-ID: <MW2PR2101MB10524E75CD610DFB4EBEF091D7DE0@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200406001514.19876-1-parri.andrea@gmail.com>
 <20200406001514.19876-4-parri.andrea@gmail.com>
In-Reply-To: <20200406001514.19876-4-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-04-10T17:29:41.1776214Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7933173e-a323-488d-ba6c-e9f3f7cf2aef;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8f8e10d3-a43d-4857-6760-08d7dd74c1c9
x-ms-traffictypediagnostic: MW2PR2101MB1050:|MW2PR2101MB1050:|MW2PR2101MB1050:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB10504BE2BCB44CAED4E5CB33D7DE0@MW2PR2101MB1050.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0369E8196C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(478600001)(55016002)(86362001)(7696005)(82950400001)(4326008)(8676002)(5660300002)(9686003)(64756008)(316002)(8936002)(81156014)(82960400001)(110136005)(186003)(2906002)(71200400001)(10290500003)(66476007)(66946007)(33656002)(66556008)(54906003)(76116006)(66446008)(52536014)(26005)(8990500004)(6506007)(966005);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bG6UkR94SqUSagu/myeufarLuShGth9li4wAsHp5ZiDVTCpyco8puNW/1SfU3OPJjhrAfjMDNvMalmT8YEjCDrDYXjBtFWYPgkpVWCP89tg5PxJ0uOg4rN8g6eqbPxQNUwWboeTdLArzoVu5hbDIIdMzSMvN7O2kPjM/aKo1pSF2n46pHdqThKb1c7tl2VjuJNiu+agQ6NJo5DsyvfhZnBRyQY+pQzDd0WqWquu0woWWbXSeww0wU59r8+JvKGE+N4MuChq+uQCcoqjxn+UWIdvvVerU3UNQ6keeMEceof4YK+XTacFRp37Cj0VdJtxRO2uxphyerCEQuOg7Hr1sGX5kJ/9ALNKEqRbL+/fMkbdGnIyol4htaDGW1MSfGFlBiwDibsy7CKTfjyHOp0LviPnjjRyjDoJuHZhzIhrpQnhSwvac94zu/5q92Lac9lPhrXDM5J0yeJq4HQN9tb2jIJV8tlm8cp3ljIRLA+yvqaHbo4Fq/G7NDUgdZ/mWG2zK6qWXoTvnvFvUQWc+fuUf2g==
x-ms-exchange-antispam-messagedata: J1PypgPHAORIuhYVvNXB9IpvH4ILWm0/uUCLpHPCZfTc6j+Zz9JMwxJZbOQq+nkhXdOoZ818ziI3jpraTd+noOxmhlY6TSpP6EgjGLDCeci+sDiUG9U6mvnm5r+wjT2fGsgir3McQ10b/r8UL+KwCg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f8e10d3-a43d-4857-6760-08d7dd74c1c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2020 17:29:43.2181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T6Qq31Ub+GJK4TvLxEsE2EjiJZsXo0Z5Oj0eI/B4HZId8x2xM+/QG3XeKWnkIv/FrbtB2kS/2oEgjvSdp9sLANlP7OjhZM05Sz7AQOV7HKM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1050
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Sunday, April=
 5, 2020 5:15 PM
>=20
> When Hyper-V sends an interrupt to the guest, the guest has to figure
> out which channel the interrupt is associated with.  Hyper-V sets a bit
> in a memory page that is shared with the guest, indicating a particular
> "relid" that the interrupt is associated with.  The current Linux code
> then uses a set of per-CPU linked lists to map a given "relid" to a
> pointer to a channel structure.
>=20
> This design introduces a synchronization problem if the CPU that Hyper-V
> will interrupt for a certain channel is changed.  If the interrupt comes
> on the "old CPU" and the channel was already moved to the per-CPU list
> of the "new CPU", then the relid -> channel mapping will fail and the
> interrupt is dropped.  Similarly, if the interrupt comes on the new CPU
> but the channel was not moved to the per-CPU list of the new CPU, then
> the mapping will fail and the interrupt is dropped.
>=20
> Relids are integers ranging from 0 to 2047.  The mapping from relids to
> channel structures can be done by setting up an array with 2048 entries,
> each entry being a pointer to a channel structure (hence total size ~16K
> bytes, which is not a problem).  The array is global, so there are no
> per-CPU linked lists to update.  The array can be searched and updated
> by loading from/storing to the array at the specified index.  With no
> per-CPU data structures, the above mentioned synchronization problem is
> avoided and the relid2channel() function gets simpler.
>=20
> Suggested-by: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
> NOTE.  The inline comment in vmbus_channel_map_relid() follows the argume=
nt
> discussed in the RFC [1].  An attempt has been made to make this argument
> more 'explicit' (and, hopefully, more 'robust' against future changes) by
> adding a full memory barrier in vmbus_channel_map_relid(): the barrier ta=
kes
> the role of the 'implicit' full memory barriers from queue_work() and fro=
m
> check_ready_for_resume_event() referred to in the RFC.
>=20
> [1] https://lore.kernel.org/linux-hyperv/20200403133826.GA25401@andrea/
>=20
>  drivers/hv/channel_mgmt.c | 179 ++++++++++++++++++++++++--------------
>  drivers/hv/connection.c   |  38 +++-----
>  drivers/hv/hv.c           |   2 -
>  drivers/hv/hyperv_vmbus.h |  14 +--
>  drivers/hv/vmbus_drv.c    |  48 ++++++----
>  include/linux/hyperv.h    |   5 --
>  6 files changed, 160 insertions(+), 126 deletions(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
