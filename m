Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 783521431FD
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Jan 2020 20:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbgATTMP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 20 Jan 2020 14:12:15 -0500
Received: from mail-mw2nam10on2124.outbound.protection.outlook.com ([40.107.94.124]:22721
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726136AbgATTMP (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 20 Jan 2020 14:12:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VamHucB0T6sjb6cQ6w/s7YOumKIDqXVMrvZF7tOf0mzBG/2gOmDQPHfwTns0BGGbxlBpn6oeJsgavWduIpgNWl/psZFHYpcz97uRnAF5Rb0LxbOu7iHgLSiVOJxJ1LxnV5VIoKN2vkFN/STZgVDbNIW9p7o0LNZJzwRXxuN5nY1t37vOF+lyJchHPqQGdUIK4cJqf+fT6rWJ+7hsyVUaTGsUtsQddfxKQr4zHeScEpdBDhhp/JYlFgx6GisgwtM9GM6HAB89g3al9+zKW0gkuG/u02hN5+S/3958RGwASeStIbE89sXRQawHPzsrp5EvgaXaVgXjSei8l0qTUc78BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlRYVQoqVcD8474af9ScKwIZnDbTxiw8pp+8a7eFNG0=;
 b=EJTMb3YOtqK/w+mFUCzqE6dr61QTYmmOTr63C5rfHw6bdL29Mc63j2WLm9jl/JroC6wJYF+KgjXHrXkAEB85PJCmEARP9hsGeH8LTStfBs+9NQFZ1j0xMTZsu5mLrT5jvBbv7kP/LKw0VotaCuuuvRu2Yjku0e4XrF3fUQCQ2h061eenRTp/ShpFcldK2PLomzcd4KdYFhtq1wLwUvJx9/u9rnLsdzT9RgN17AFQ2FlLJ0fsrK9W80RWHKA3eYT4y9uGhuh4LIasQCnPMgh2wA6Xarlsi9TMkT+2Rgbg1HGH4bNNi24y7M2YgesPZZ4C5P+ToKCtsITxPufbgBVBOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlRYVQoqVcD8474af9ScKwIZnDbTxiw8pp+8a7eFNG0=;
 b=dy3KsyFG6FMKMYJHLeS89BV7EH+WqEw9YaE9iqrZlCbVhcZVtxfCBgrbm2SFBxqPR+lnPdSkOv3scrIldB02vV2kNYf1HZIgogdMWuiqCwkdJRqkL0m0/JrW4GgEcQsZKi0RgAn5DHfqQXr+kitPYjCqvAAyMcU6yDSwCz8ZUEw=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (52.132.149.16) by
 MW2PR2101MB1131.namprd21.prod.outlook.com (52.132.146.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.4; Mon, 20 Jan 2020 19:12:13 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::f1bb:c094:cb30:ba1f]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::f1bb:c094:cb30:ba1f%6]) with mapi id 15.20.2644.015; Mon, 20 Jan 2020
 19:12:13 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "lantianyu1986@gmail.com" <lantianyu1986@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "david@redhat.com" <david@redhat.com>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        "eric.devolder@oracle.com" <eric.devolder@oracle.com>
Subject: RE: [RFC PATCH V2 3/10] x86/Hyper-V/Balloon: Replace hot-add and
 balloon up works with a common work
Thread-Topic: [RFC PATCH V2 3/10] x86/Hyper-V/Balloon: Replace hot-add and
 balloon up works with a common work
Thread-Index: AQHVxVvQ02alYkCFnUKt/8K72MYw8qfz9n3w
Date:   Mon, 20 Jan 2020 19:12:13 +0000
Message-ID: <MW2PR2101MB105232ADDEC7A4E5B6B05D61D7320@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200107130950.2983-1-Tianyu.Lan@microsoft.com>
 <20200107130950.2983-4-Tianyu.Lan@microsoft.com>
In-Reply-To: <20200107130950.2983-4-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-01-20T19:12:11.4411420Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2e67ac73-0126-45c2-bf72-026c7da8673e;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 036b1b30-e9bf-4db0-d0b1-08d79ddca847
x-ms-traffictypediagnostic: MW2PR2101MB1131:|MW2PR2101MB1131:|MW2PR2101MB1131:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB113161040086B5ADF92A626ED7320@MW2PR2101MB1131.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0288CD37D9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(136003)(366004)(346002)(39860400002)(396003)(199004)(189003)(7696005)(186003)(52536014)(26005)(5660300002)(8990500004)(4326008)(10290500003)(86362001)(478600001)(6506007)(76116006)(2906002)(54906003)(66946007)(55016002)(9686003)(33656002)(66476007)(66556008)(64756008)(66446008)(110136005)(81156014)(81166006)(8676002)(316002)(71200400001)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1131;H:MW2PR2101MB1052.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nxtLry7hKBHktXIbm5620sVJltvF5nd5ZJffQJTDooPcODM8ezy+V+UoiaTnLdkcwnBPi3oIqHBrImKZWmenf5aewlTXnVH5O5Fk24wd+D/ZlunInOLP1h13N1XSNd8w0Ta9ARhBqu/dzMbW6irMQRm3ReMipM/fjj9G4gCMMd9157VZNnbTkoY37jLozYlfQvuaDZBH89HHoS7jKehDXXdB+SLSp1eYjVVSb4OW1j9wqBngeMgV3IG+V/DfLTtYdEMn3ZCnfQawyCblI8B6khxyAiWr/XNUs20bTUI0qhzEEPezhYhk1nNibVqEK9reYNlcRLOr9DQSd/ilJnCsXZSc2CGROz7Rs8sGtD7dpAZPvurcx3WK2PHhizcaKeDiTh2dE35CCBj5BOgCw5SJRfuh0rEAu/eyn8LoNej1cBUC8GJBXFdiNlm26tRh3AIL
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 036b1b30-e9bf-4db0-d0b1-08d79ddca847
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2020 19:12:13.5790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z7jt+lAMmMr1dl4ZipE3uZwUOoiZ7VMaX3grkTBSOVVkgxZOcy4kOMwDkWLSpSCeHYb6w7MZtrQ8xSECJsptxHvHOcuMck0ZrtqwXJdG9aY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1131
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com> Sent: Tuesday, January 7, 2020 =
5:10 AM
>=20
> The mem hot-remove operation and balloon down will be added
> or moved into work context. Add a common work to handle
> opeations of mem hot-add/remove and balloon up/down.

Let me suggest some improved wording for this commit message:

The Hyper-V balloon driver currently has separate work contexts for memory
hot-add operations and for balloon up (i.e., remove memory from the guest)
operations.  Hot-remove is being added and must be done in a work context.
And finally, balloon down is currently not done in a work context, but need=
s
to move to a work context because of a Hyper-V bug that confuses balloon
operations and hot-remove.  Rather than add code for two additional work
contexts, consolidate the current hot-add and balloon up operations onto
a single work context.  Subsequent patches will add hot-remove and
balloon down to that same work context.

My assumption is that the consolidation into a single work context is
just code simplification.  If there's another reason, please describe it.

The code is this patch looks OK to me.

Michael

>=20
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
>  drivers/hv/hv_balloon.c | 86 ++++++++++++++++++++++++++++++-------------=
------
>  1 file changed, 52 insertions(+), 34 deletions(-)
>=20
