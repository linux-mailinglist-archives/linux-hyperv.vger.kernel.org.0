Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC23576622C
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Jul 2023 05:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbjG1DCC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 27 Jul 2023 23:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbjG1DBw (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 27 Jul 2023 23:01:52 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020020.outbound.protection.outlook.com [52.101.61.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD8A2139;
        Thu, 27 Jul 2023 20:01:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mPJW/EQO99IqPZ3HaIaODJfa9ySVqCieeEum2NfSVBnhGk3sHc02GA3Iu6qDB7DGEb4762bcyEI+qKt3aMTY26ZxmBxDACZzdAzKZ94J0nzJCjvWoVY4ygoip9/jKvATD4zvReuB8saxEwLJ14p4L/0aaGuPevIAkr6++McYSgGY48ZbOKDLRL46RW8VO7F5v1iDvYScxSLQJzwMaLr+mDW20HQwR+sa30CbOoWPyGYUVaF7LvFrhtm9JudK9vojGNW3gv6snRtwKozpYq9+3Bx2O9Nc3iRtDiOG1czErfiE3hiIPaHe/5UUqO+utdrtO/GJ3sSC/GzM5tYogOdLhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FRvoMXXarnRQaLc2utv9QwBg+e9no3/WQFeWndYYP2s=;
 b=A6noVhVXcrRrd9xJsv+pyOncyeBSsz4IF7mzjwQN286nIhNWcJAze9epT9XqOmxjyn2ejaR8ZnyoAebcKkSe932+cYnqle9kt/kTVx5dHcngpgJR6mL8Ovx1uS7IwPwe3Llh3Iewib5l3g7CX2N8MSHF1Ihh4zexjaA3WBjvv22kJpXv8nOt+zxIntIB0C9FBVb8cmVnaDV4k2PGAGmUFl4ZVbKno907dSv4FupIAiTlOlZyYhuaYGuOflNC526JCrfsZyB8NaVr2ggRlsxWE44GPnRG2mxVOYVtixrsu7CLT2sG36NqElcWpEswbvrMS65dpEKpgKphmNVYVxKz2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRvoMXXarnRQaLc2utv9QwBg+e9no3/WQFeWndYYP2s=;
 b=GaJgQue+uUeB9CwvdFQM+iHqmagTeqNQmhZc9xnD/HxdyemL+LI4wxmXajIGITEyGHUkFOjMjVo76xSagOpfEkWP6Spc1AvF/h3svjQbdLx6wmSHJI8Yjj8lngLnYOcvI6GYfE/654UQR3SHoWjWwSGmRKS8Kb2VrzY3697WNXs=
Received: from BY5PR21MB1394.namprd21.prod.outlook.com (2603:10b6:a03:21c::20)
 by DS7PR21MB3365.namprd21.prod.outlook.com (2603:10b6:8:81::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.3; Fri, 28 Jul
 2023 03:01:45 +0000
Received: from BY5PR21MB1394.namprd21.prod.outlook.com
 ([fe80::9e52:d01f:67f7:2453]) by BY5PR21MB1394.namprd21.prod.outlook.com
 ([fe80::9e52:d01f:67f7:2453%6]) with mapi id 15.20.6652.004; Fri, 28 Jul 2023
 03:01:45 +0000
From:   Ajay Sharma <sharmaajay@microsoft.com>
To:     Long Li <longli@microsoft.com>,
        "sharmaajay@linuxonhyperv.com" <sharmaajay@linuxonhyperv.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ajay Sharma <sharmaajay@microsoft.com>
Subject: RE: [EXTERNAL] [Patch v3 0/4] RDMA/mana_ib Read Capabilities
Thread-Topic: [EXTERNAL] [Patch v3 0/4] RDMA/mana_ib Read Capabilities
Thread-Index: AQHZv/zyU+rWNq0MNkyRetXdYpFlI6/Of59w
Date:   Fri, 28 Jul 2023 03:01:44 +0000
Message-ID: <BY5PR21MB1394D8F169F113BB70FABB47D606A@BY5PR21MB1394.namprd21.prod.outlook.com>
References: <1690402104-29518-1-git-send-email-sharmaajay@linuxonhyperv.com>
In-Reply-To: <1690402104-29518-1-git-send-email-sharmaajay@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=458adced-8393-45b5-9d4e-45327b35987a;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-28T03:01:26Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR21MB1394:EE_|DS7PR21MB3365:EE_
x-ms-office365-filtering-correlation-id: 923b4194-e421-44d7-4133-08db8f16fa10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A3TWtpkou4jIMa7bB3BjJbcR0CDPIYUETFH3fcJR0zGKbUoE7Cw46K/iY4jb3csP8+1LI3xbIIF436UIgekaJQEGs5cBdvUfXqK3FucQ9klW2yImyDw2uBx3bPL5UdgsSbjxIxhMWLJI8Cuxg84PQm6UVEOp7ofr3IUp6j9rIen+6MqMhWga/zqzOSni4kZSHYFt+peiiv/NiYaMwlYb9El4PJfFwVpEjsp0NbUQmNIl8hO6o5APD7W/VmLav4d/7UL3Byhc4TMzdy2tvMEmjMATSuFomca27E28X0+OlewznyNUUVu2m8lTgjI2iNdLrZyPfgeu8Uwa8EFDXnkIaXUpfD8FzCI1dvvJYyZiqdI7rVwvRs617qKgh0acyM8RWG5LHwY8a8KH41BvsYckkITh1m9Srrd1FUBp6uS0echejFaXQqpnPj6PqTYFZAXdnReWeRFepwWUNViHw1G7RwerA6BgC9UL7urh3yeHu9iyJ2YE8kittEANdtdAd4esJ+jWH2aYBfCYQMDBpKVPmXGt2qzDC86ITiWpc6zO1Bco5q2ox877mxtQK5Vb3KtEa1BTIzfpxfxd4CLdAhe83JGXo8O0QSHWv3SiTqVbJwchfqt0hKD09gGoCtAvp2h0VSOGKciR0M/0U7sTSSj9Z5Y+UaSHr2u2kxH9TupMty6UZseOYsZyWiStSHIZUeZJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1394.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(451199021)(7416002)(38070700005)(921005)(33656002)(7696005)(55016003)(53546011)(6506007)(83380400001)(66446008)(64756008)(9686003)(66556008)(186003)(38100700002)(122000001)(107886003)(76116006)(2906002)(66946007)(66476007)(82950400001)(82960400001)(316002)(71200400001)(4326008)(5660300002)(8990500004)(41300700001)(8676002)(86362001)(52536014)(54906003)(110136005)(478600001)(10290500003)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4GngBbCpZHrDrnZXVQxxR5maP5FjfwjVhqPqJD8Erzsm/eH/Ackh6EWIs7ma?=
 =?us-ascii?Q?G2UEkkafhoWKhHXdoxQ8VSmvBx0BaUVsikGy/AW+2yLQdp0LYeCJNapby3MI?=
 =?us-ascii?Q?IIC215z8mH8I7Njt5YlzaUK+aONKTs2aDf50gJ/hgmZw8OSDgRvLudY0WQvD?=
 =?us-ascii?Q?CHQFRaGkmq6LeMOQlKAqXPRluPbfODrvAgLcR5gZCLFmxAmjErqAm2lyhlpr?=
 =?us-ascii?Q?Maxqguj3m5M1EdwHDLrWk3tn0CRYju2N9eiul8e/uCnyAFXkeFaX3zf2UdlH?=
 =?us-ascii?Q?pxEP9CunxVv9HdNZ1krrfItv8D9ao8u6Agk1G5spLU+TQ43WxrUDNIQreGDT?=
 =?us-ascii?Q?N7as6O2sTIg0HercA308wiyhlI0U32tqMcdiqrb6nG6Lj/2AWs5WqhdPPvmo?=
 =?us-ascii?Q?YgeimQ38tlvfVPNaU3lBEzsUcUPBKzXt8x/GFg4UI8ZvNVqOA3COq33Hgy+n?=
 =?us-ascii?Q?jVMQgHJBq7FyJzENhZYFTJOYIaiN0iBplkjooTnwfuUHEnqTK3ZMzeKdOdN5?=
 =?us-ascii?Q?gGa7yju2kKJRpaLaVhpznDeaOnlP2sZHzl39jH2e5Qgu+8+XLIaYvEjvx3T2?=
 =?us-ascii?Q?EZVgBJlm5xKF3dB1wvAVlikMBOFEsq3of+GRGbs2OARiGiQTPGPLoa5BDSux?=
 =?us-ascii?Q?FKfMxic2kqS5YS4TR+F8XSlHLtCZ38LM+CxIPidpY6U5IU28UDGg56YnwphF?=
 =?us-ascii?Q?IBQRoPAglzD92YLIfGPY0KFH73Y0iE/dEXgZQLtUQOVWVe7GLjlrdftIDjqO?=
 =?us-ascii?Q?M4LVmCi8nlFWEeuBG9o7OLHK+e4WoedIwa9BVQE0ehpIh8HbwzW0+vpNwY4M?=
 =?us-ascii?Q?JDxd+Dqab/ZrkQ8w6NpOTwoQpKCZ7tBSuqqRUK4/K2phzgPMu++Z9N5goGxe?=
 =?us-ascii?Q?sqXyRE4KD9Cm31I3Oa2gFYO1B+SFrLx8KZKhca/wtn8Qcg+hp25Z6j87TJBG?=
 =?us-ascii?Q?/DP7sHuPMGAsYlSwx/oTnWYvu7gKCaTAGOlSTWYP2PfM4ePxzSUYXQqGK7dz?=
 =?us-ascii?Q?PFM1f2PpkRF4ayYnY+0feECEnU0njlQ4E5hQufRRNsNAtHsIMoE4G+V7wOmQ?=
 =?us-ascii?Q?M749V5b860dojPDfN0DXg2bmd6kR/8amvXuLODWg5oQG0s7b8MS5o2tTfR00?=
 =?us-ascii?Q?92sE1syLE1sy4ZmUNU4xgbo/PZqqMobe6IGezhYg6zXOrERiTFH5Uc4Nbdxm?=
 =?us-ascii?Q?/JGDQKd0jiFEnksOWLp8JHLZ+So8PZRdDg7WIUfJKWiYdf8fOhAvkdIs7we3?=
 =?us-ascii?Q?kR+OEL/AeuFw3nAOjoZLeCf4HVXHWO0a2tXD9Oyb7F57vFNU7SXn+7UXwqz5?=
 =?us-ascii?Q?RvEbr0Ywko5TmB4S5dYKvoGh5IX+JfKrPLOfKNE08O9ONYlJFNBNl+zTud1I?=
 =?us-ascii?Q?pi+JOaoKgEJ33cN4UCvTE0X6LAQRhhA0Fq7shvZSwKCc41neA2MPIQFBWmEl?=
 =?us-ascii?Q?1wjEqPqiw6aHxzKHnLTfAyCagZeGp4ZbZlJKqaRBtBRezWY2awmtRr2ZK7YR?=
 =?us-ascii?Q?iMs/WZyrvn0rbNDiAJ9sbnB3ThQdJey3uGL0rfNpmuLp/saNhmP5QWHLa7w5?=
 =?us-ascii?Q?QmqR4fGNhtdr6sjbcnVVOn2P+QNnn8UE7b6JLMJ+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1394.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 923b4194-e421-44d7-4133-08db8f16fa10
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 03:01:45.0029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D4NdLkik8tqZue7XL6ReyoYYtLNyctIEeLd/KPTlbrmiBUlm2027lr9xGzmIPBQ3Ku3VJR8sZsSk8RVQsPJVmUkSxNHqxhI/bT7yMcK7f4k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3365
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

+Long

> -----Original Message-----
> From: sharmaajay@linuxonhyperv.com <sharmaajay@linuxonhyperv.com>
> Sent: Wednesday, July 26, 2023 3:08 PM
> To: Jason Gunthorpe <jgg@ziepe.ca>; Leon Romanovsky <leon@kernel.org>;
> Dexuan Cui <decui@microsoft.com>; Wei Liu <wei.liu@kernel.org>; David S.
> Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>;
> Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>
> Cc: linux-rdma@vger.kernel.org; linux-hyperv@vger.kernel.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Ajay Sharma
> <sharmaajay@microsoft.com>
> Subject: [EXTERNAL] [Patch v3 0/4] RDMA/mana_ib Read Capabilities
>=20
> From: Ajay Sharma <sharmaajay@microsoft.com>
>=20
> This patch series introduces some cleanup changes and resource control
> changes. The mana and mana_ib devices are used at common places so a
> consistent naming is introduced. Adapter object container to have a commo=
n
> point of object release for resources and query the management software t=
o
> prevent resource overflow.
> It also introduces async channel for management to notify the clients in =
case of
> errors/info.
>=20
> Ajay Sharma (4):
>   RDMA/mana_ib : Rename all mana_ib_dev type variables to mib_dev
>   RDMA/mana_ib : Register Mana IB  device with Management SW
>   RDMA/mana_ib : Create adapter and Add error eq
>   RDMA/mana_ib : Query adapter capabilities
>=20
>  drivers/infiniband/hw/mana/cq.c               |  12 +-
>  drivers/infiniband/hw/mana/device.c           |  72 +++--
>  drivers/infiniband/hw/mana/main.c             | 282 +++++++++++++-----
>  drivers/infiniband/hw/mana/mana_ib.h          |  96 +++++-
>  drivers/infiniband/hw/mana/mr.c               |  42 ++-
>  drivers/infiniband/hw/mana/qp.c               |  82 ++---
>  drivers/infiniband/hw/mana/wq.c               |  21 +-
>  .../net/ethernet/microsoft/mana/gdma_main.c   | 151 ++++++----
>  drivers/net/ethernet/microsoft/mana/mana_en.c |   3 +
>  include/net/mana/gdma.h                       |  16 +-
>  10 files changed, 529 insertions(+), 248 deletions(-)
>=20
> --
> 2.25.1

