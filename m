Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C566EA178
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Apr 2023 04:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbjDUCIL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 20 Apr 2023 22:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbjDUCIK (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 20 Apr 2023 22:08:10 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2805C40D2;
        Thu, 20 Apr 2023 19:08:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IvhKicGbR1V9LVMK9v6gqbzq/TCT9Gyb8N6V91xrcdiB5/pKZvry6IyDwJzoatDTH20eVE/Uio3hGVc6HF44lo5ODMAdvFFuf7oXW/LG6yxeBQHVV6nifhOQOr8K6ChiuSUnWcZESJI/6GnxdE7M2pXTk5p7icFteUgnkMcr5P5zxmq+DZk40j/7DLup4wV42pxfmSNuLvGUV4sx74T+QDfwIfDp3nQnjOT1T3Gysy7Min2c75jEbw5xUEJ/sb/E3Vg0rsSctU2g/NXFLQTj6Nfs7v7ilcTBOLKm89ivG4RjKH05Ax5rSNfVHFxRy25MlNe+gMU12POlkDYZz5xmHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGdjQPtoWSBFPVn5xzn/nmPD6/JZ4E+K4bidZ3NW8II=;
 b=UQPzKc2VGOBMuTyUxss3IheReN/wGhiOXrrInTSTG/w/fO6m3xLaEJGFT2Wgi6owMdu5iALSYxB/oWQd1fpDv/TLrkHixNiWr2rOzJL7AuNa8mdzMME3ZM9WeaAmWgaZUWg5cHCtIB95xsb+D38uPvaA7nGfV2Y3QypMzv77kNFStNlS1Zc0mY8UE5JUjfYQAicL2vRh0j6ZX4szRg6pjaTwfSMWZXo0dd46ezN208tR1WtJvSJmBZU8kORTrrFXS0C+e539kj40Chfh6l0UHXLkQvacjSoP31jy2TvPEMspOCDjsoS4k7XkAB09qAwD7tgnnOr/SalbqtfHRhKgzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGdjQPtoWSBFPVn5xzn/nmPD6/JZ4E+K4bidZ3NW8II=;
 b=VfQV2vcs2T2cVuHf/3cYJ/qpj5LjNHP6JslLYIM6X7CHoeo0sr2Z7NC9AiWMoy8wOmj+TQIlprJbOh3rqWDJtADibExe7vhdUzt2Kbd2Kq6h1OdxRdfdntZti3A/p/2zPJH8wajHRCzVJBGMeLA0TdZ0h5RQJPGkV9eSPkEJcZI=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by CY5PR21MB3492.namprd21.prod.outlook.com (2603:10b6:930:f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.9; Fri, 21 Apr
 2023 02:08:05 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::eeec:fa96:3e20:d13]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::eeec:fa96:3e20:d13%6]) with mapi id 15.20.6340.009; Fri, 21 Apr 2023
 02:08:05 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] PCI: hv: Replace retarget_msi_interrupt_params with
 hyperv_pcpu_input_arg
Thread-Topic: [PATCH v2] PCI: hv: Replace retarget_msi_interrupt_params with
 hyperv_pcpu_input_arg
Thread-Index: AQHZc/DpbvkOPfUdZUmIvrTKcorWRa80/VWQ
Date:   Fri, 21 Apr 2023 02:08:05 +0000
Message-ID: <SA1PR21MB13352587E3078F61A4DA1BE9BF609@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230421013025.17152-1-decui@microsoft.com>
In-Reply-To: <20230421013025.17152-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=94dd896e-8d0f-4dcf-abba-7c0811d2a2ad;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-04-21T01:43:01Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|CY5PR21MB3492:EE_
x-ms-office365-filtering-correlation-id: 5a1eee42-f54e-4273-649a-08db420d3e98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JYXJQEQPOoGqJIEg2JiT8m4FD+SzI56w+A/V3gFQETX8DjP/eplNDBXtN3RYE8UTgweapAG5UDr6ShClL2cbjUm/uc2RxUZapf5ZZW8jS3XvIbJk/kX86YZ5jh8ab64mR+8BqI8BVbrc1+QfQhngObZcqf8dIz0eXtseVV2k5ZS9hJATbcymW9x3DGxdhz/B/RtnTdsoLg6SHVlIk8hakljWEFZj/B+AgJKa8lEq2eaykRpgjnPW2HPDZTsYz6J4Qql7/CT7cLX8JyRd+a9cR8LeGwcZHm1kM4lahbq3cZCqil0+2JxTFbHTkETBqX/B85hU+Mc6rMxrgMkm17CXT5fp4Av2PBVxqYEe3Bm9DAsx5tR9TXLCFxtU7XzESPsdvE7U7ogZwlkOFVhOMYhZ9pgOCyfJf/7yTcNuxYb/IKtMP46ci/DipUSOzhspV9RZUWSGqnRhLL09L0l2C+TkItQCQ01YF9k/fmt126JbmvcQL9N/2zamcQA2g2URSKbkcfLgmxfxFnQKG2O/KphlkHDnEqf7seLBwbLfjkOcLd0fLcMjuL/RSMu3bgiDUk9SrkNxWtDxyrp6svXwrjGtH24wJHXa6uh7/dBkRfUC3sPa9ccXJuFVatYOMyAd0cHO7zSwXCMkR3fy0s5aYpTnDd9wAL0YGTj7D4shLLRcYpE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(451199021)(8676002)(41300700001)(8936002)(55016003)(2906002)(966005)(38070700005)(8990500004)(52536014)(5660300002)(83380400001)(921005)(86362001)(122000001)(110136005)(478600001)(6506007)(26005)(9686003)(7696005)(38100700002)(186003)(33656002)(82960400001)(82950400001)(71200400001)(10290500003)(316002)(786003)(4326008)(6636002)(66946007)(66476007)(64756008)(66556008)(66446008)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zZSdzv1z5ZCF67uOxF6OPR6VuyvprEJ8C88K3DGFbqnX3wR1kK227ZqAomCa?=
 =?us-ascii?Q?hwMYtc6fEdpuhsYOoIwsGYjCa9t60WfJD3i67WCmNi+6WDWL9j2rMHgO3ota?=
 =?us-ascii?Q?C+N+fLmQIvgQdnMecQbPlEhi2lq9j6Kysc8MzfXZzTUPepJoGhB3C8IbtEzk?=
 =?us-ascii?Q?1CGeSs0nRvMHs2rnZsPBZz1b7pQFmiGE835iWvLNxiP/P6VTtTst7obXzIaH?=
 =?us-ascii?Q?azmYk06uJFwxUo0bQqTT87fw/kOOaytuBhBcjZ390SFrAuePdQhnBeaA52vK?=
 =?us-ascii?Q?nWHGhIEu84iMHytbCE/JBbZelsVFp+DLTHrPMz61NCTdA9HzWtpsp38SWg3P?=
 =?us-ascii?Q?OUGP/f8i5ikLqYHmGv7NfFMmiZ/LdCj/VD3pDHqjbWLt9MAibC2fIGC7hRJV?=
 =?us-ascii?Q?m6xMV/z7JY806txcTCbdv0fs5Eij0NaejQGyYEogdBDi8RSPCB8E64WG/aPl?=
 =?us-ascii?Q?+5v6YnOS7RDGIWuU4QnMqIWLov6hmA8rDNLDYfW0u8j5gp64ymqH5Cl0CPzY?=
 =?us-ascii?Q?LCkJvbqK8LUYF/Xha1Ov0EOuCuTl+YgDLVTlggAQn6hYyZoAdbQO50+q3LoM?=
 =?us-ascii?Q?nrmZLOBdeHtd8B9XRqUzdO7gwifp921Qa6MbVV+5+zaCJk2pdcgQqVl1mowX?=
 =?us-ascii?Q?mHIho4F+pP/Enrg3KbA/6Kjvya77o5X6ZrhMKmRrwSkcE05kk0B2CPwfJF5p?=
 =?us-ascii?Q?LFq6q6mxUF4vnbfsi+5RIb6f6noaQ8kUUSY1LMZmjBfORezSykbxsaMKp/7E?=
 =?us-ascii?Q?RxKRZWtn4J2L7Xxuy/+UcSFcE83LFBSn2xS0UY7oVQnktYT5Qg6fREpl4+tE?=
 =?us-ascii?Q?IGerBK63sWDP6/pCEUwAjAQDLH5+BaKea/ExZq3Gqu2aIUWA4JncXIl3qkxO?=
 =?us-ascii?Q?u6dm757UiPib6B6cGkNed8Vs96KDic+2CXV1CNYYLTHl61ARSNKjW6IxcLfI?=
 =?us-ascii?Q?AGqPZ3hFmNZZSpK9PSkWHJZYudXGakK7jF3outLNlUj0VY1ulZ6f6cMggLgC?=
 =?us-ascii?Q?aHcJ8DvYnzRxV1wlUaMBOMzTv/93zjBjiCoKCgeS4+RB34SYgNIhAylR7TSm?=
 =?us-ascii?Q?5nSgYyCeMzw8zxR0jvOCDjfE8m4iHNZG7jhQQG5x4EhiXUU1QGV05k2D97Nm?=
 =?us-ascii?Q?eszlYAVSaf4PUKSgYe2RIdjk7DNAnMRJMz/UzAldqohBJinozEu5WcHzDOoX?=
 =?us-ascii?Q?Lxsj9Xfny5nvadHliLivleoIyNiTm9FMNOtnmrVFazb/hv1Lvnb4s2+ML7rx?=
 =?us-ascii?Q?7GDeXFzXUc2f1YO3gT+aSiICoE2q9zhY13m/qKtOheY8k0ByTX3hoRLTev0U?=
 =?us-ascii?Q?/2tjRK4GhxgAqDpZhO98lE+yN+MwTfrdpBFCslOLOigLnEKes97iS0g2mdMP?=
 =?us-ascii?Q?qhbIvnYJwvYtd52h3gp8JbRq/WOFc/9ussyZhlB+nQaKObxgtn5vFXbrvnk+?=
 =?us-ascii?Q?PeBlkoO28epDaDUHCFDnDcGWJg+IUd99Yu9eo1grui/puat8v7lYdHliY2Dq?=
 =?us-ascii?Q?VyoQgjiKdzPLED1qVG9WPnnWIWahZfx2V7qv0m3tjuOh+DjmNNnRM4LQw6pn?=
 =?us-ascii?Q?/xTJ+N/5iEOqMAJtvAk/daeL5UWeqD6GkGf1Q9Eb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a1eee42-f54e-4273-649a-08db420d3e98
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2023 02:08:05.4671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JMIAgitFFdVed9QeTi1r4K7/LhLCjbH2jipCfv3ZV2X0dCZSX2O1zQsBS9qsnL11GIUg4mFWFDkN2k/qMpItDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR21MB3492
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Dexuan Cui <decui@microsoft.com>
> Sent: Thursday, April 20, 2023 6:30 PM
> ...
> 4 commits are involved here:
> A (2016): commit 0de8ce3ee8e3 ("PCI: hv: Allocate physically contiguous
> hypercall params buffer")
> B (2017): commit be66b6736591 ("PCI: hv: Use page allocation for hbus
> structure")
> C (2019): commit 877b911a5ba0 ("PCI: hv: Avoid a kmemleak false positive
> caused by the hbus buffer")
> D (2018): commit 68bb7bfb7985 ("X86/Hyper-V: Enable IPI enlightenments")
>=20
> Patch D introduced the per-CPU hypercall input page
> "hyperv_pcpu_input_arg"
> in 2018. With patch D, we no longer need the per-Hyper-V-PCI-bus hypercal=
l
> input page "hbus->retarget_msi_interrupt_params" that was added in patch
> A,
> and the issue addressed by patch B is no longer an issue, and we can also
> get rid of patch C.
>=20
> The change here is required for PCI device assignment to work for
> Confidential VMs (CVMs) running without a paravisor, because otherwise we
> would have to call set_memory_decrypted() for
> "hbus->retarget_msi_interrupt_params" before calling the hypercall
> HVCALL_RETARGET_INTERRUPT.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> ---
>=20
> Changes in v2:
>   Fixed the inaccuracy in the commit message (Thanks Michael):
>     "Confidential VMs (CVMs)" -> "Confidential VMs (CVMs) running
> without a paravisor".
>=20
>   Added Michael's Reviewed-by.

Hi Bjorn, Lorenzo, since this change is pure Hyper-V stuff, I'd like it to
go through the hyper-v tree if you have no objection.

The hyper-v tree already has a PCI patch from Michael:
https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/commit/?h=
=3Dhyperv-next&id=3D2c6ba4216844ca7918289b49ed5f3f7138ee2402

My patch won't apply cleanly without Michael's patch, because we
both changed "struct hv_pcibus_device".

Thanks,
Dexuan
