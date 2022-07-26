Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7B5581471
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 Jul 2022 15:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbiGZNsk (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 26 Jul 2022 09:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbiGZNsj (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 26 Jul 2022 09:48:39 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11021023.outbound.protection.outlook.com [52.101.62.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BC41E3D2;
        Tue, 26 Jul 2022 06:48:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hj9RZIHIFYXyHdStx4vvlEvBq1D1Be0PEYJ2GuntUS7pobwLnb+XjAUlkQNKI61Zz1yWtXHuL+x4z+mC3WJTTWcmQ8ElsI8cuDxrCmwQUYmt35gpmBgLLCo/FE2RPe69R0YDhtEnDNPfWVlaMWrGrmLcDQzIeWJ985rC1RhyA6Q8XXjBLZ0eeqGl5npQK4193E9ayX05C3CWP/i6szei5FxDCsQs2RtztJLLPsS+zRZ9/iaz9EfEF0fA9moR5gFWua6z16GQtToNVdy4CHl1G6RuroMmhAbNevpQHCePiFoS9ud6UOQCJpXMvhxMORsCvLRg0qd42KdViTnKCATmzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4kXQipzRl90z83DhKRBC/jcYdeuYN58+/jj3cV3AMA=;
 b=XCiYVfxu7KMX+L2zu6fPARoRMll9NJWH0fV4w4A00EYlyOertnTZ8FYW8WGLFqlZXQWXG6qHFjbVOJ4E4lwyxqv0O+UFOIqn+ludM/8AUweWbmbfUqsHQ/ZJ/IEafVTpnOlJpWWCiVNZ+255kD3NswQwgGnwFf1Fn3b8YZQdMwwA63K/8XjDtABPuRhOAylCTHscYSrzHoBw0t+3z+X+qCVy/qBvdmEmmLg4aeFZzfYmo22n5djrdOL8FoOq6zC8Gq6wd/QKk9jLdVvL5iAvhvqk3BlnycVm53U3HStVQ+EhUQvUyAu2+WeX9dmSBG3U3knkkQDzhGz8A0Sso9aGnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4kXQipzRl90z83DhKRBC/jcYdeuYN58+/jj3cV3AMA=;
 b=CquYIvjzP+YeLLwHXNlRDx/Q1BM8kcPHzQnH6XeKP878HKeoCZDJpodBvL2qBAzBnWKC2zqVftDIAMtHowlgx6O/P++mKdIohFD8s1s82Rkjz165u9Fy7fXSgrN4PnmHypqAWIR5lRR4QZz7IryqSUWlkMTDPE1CY+cVIvf+rDo=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by DM6PR21MB1529.namprd21.prod.outlook.com (2603:10b6:5:22f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.1; Tue, 26 Jul
 2022 13:48:35 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::ddda:3701:dfb8:6743]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::ddda:3701:dfb8:6743%4]) with mapi id 15.20.5504.001; Tue, 26 Jul 2022
 13:48:35 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>, Joerg Roedel <joro@8bytes.org>
CC:     Stephen Hemminger <sthemmin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "samuel@sholland.org" <samuel@sholland.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: RE: [PATCH 1/1] iommu/hyper-v: Use helper instead of directly
 accessing affinity
Thread-Topic: [PATCH 1/1] iommu/hyper-v: Use helper instead of directly
 accessing affinity
Thread-Index: AQHYoIotS/wddpzfUkKuAt8ax//n6a2QPgYAgABiroCAAAidsA==
Date:   Tue, 26 Jul 2022 13:48:35 +0000
Message-ID: <PH0PR21MB30257E59393883842CDE0992D7949@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <1658796820-2261-1-git-send-email-mikelley@microsoft.com>
 <Yt+Uro8y219/MNFE@8bytes.org>
 <20220726130909.jnj5etogffm4b2c5@liuwe-devbox-debian-v2>
In-Reply-To: <20220726130909.jnj5etogffm4b2c5@liuwe-devbox-debian-v2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=938c26f9-6dbb-4725-81b9-bd701dc7d269;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-07-26T13:39:58Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c07cf5e-9d2e-42c4-03fc-08da6f0d894b
x-ms-traffictypediagnostic: DM6PR21MB1529:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IhH/QdYtw3QaeDFccNdjvFhs6Jc0Yi0rwnf32MY6krfiqVNclcvs6ezAJlYF948kIkqBoSVU8cdMXg8VBVmsrLRcQYuVXcSomn/evbVhDDaYxucq7tgaeU1JYLvKtYQh/iY2XS+VGuMDKn4/4umyXTCE7OrhGHBAuoQO18o1pgV5mpWb1/rFSHELMUHFsQHOoTLLaYKsU1yOSCpZ//JZKsdxRrIvYXTaYJFfk726RbT3fe206mRTKuXsV8Y3EeZkZUsWVEcM89hE17OLhtxzmyI/eqVqOfuNctDJTcK1h8f8CdGvRziIQZB9tKvRc3hfZJ0u3226CLttTY1r0jtND/XZe589aLYNRY2rjI2ELIqjm9WHIv+DAba8eWFRCQ1TvLfAkL3PmCpLMcdd+anFbggEZtYuZUkZ3jpxvMl1EmnWB7FxhysT5w4WYKNR/KD/Z08D90lhvnquoV9mFsLwCrcEY7xtMBYAiLYxeQ+ZvB3xI+KL+CtCAh7LoCweK2EOaNQEbJn04B/mNALtdgnVetJEpYRPFhXLlewcTajfLmVbuw1i1H8YN94HkY5rfDAeqnxrauWV13+COl5Pr1G4ywco6fucwV4Fejg0Sz5lLdJTB7ADFZxC5jcbNXARTYQbpUGIiXpUFQsgx6X1RwI5RvrpNLbIq82tvR9dZx+JXT7IMxFrsSRyCunhSborlsEe843LeRfCfJOG0UdMnq+2uC2yFhopnIcfh9bMU+t7pGdmQN7BfnNGgDkW+TcPCWP+YoiL3LOmvXuw0QAVzmDR3XastYM6Q9R4MkYEUuJ1UKup7GP1S2xtRRh6FKe8+TzIqFgxZBI8gBDV5HcVcrw0G+QEgv8DhPs/8IPVV+6fF4s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(451199009)(8936002)(41300700001)(5660300002)(38070700005)(83380400001)(186003)(82950400001)(122000001)(82960400001)(26005)(86362001)(38100700002)(55016003)(33656002)(52536014)(10290500003)(478600001)(2906002)(54906003)(66476007)(4326008)(6506007)(66556008)(64756008)(8676002)(71200400001)(8990500004)(110136005)(9686003)(76116006)(66446008)(66946007)(316002)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OCjBfYjPGB+Qiu9HiPlTEomApQHaIGfcJbmejYn0tHVfT0d2RLhu4yJBUPdZ?=
 =?us-ascii?Q?a7ZV+zHPYKYjupRcF0BAhteKTNgrCKJzOAT8E2zHUDnu5ptzTnwAdmODsX7c?=
 =?us-ascii?Q?A8AwFh216DpXeMx5rYC/32sivvZMuoI6q3tvcT+C4F3wgaUWAc6FxW09SVyq?=
 =?us-ascii?Q?SLZZKgkB/6jfwVNhygsn0JJhXC8LVkbyh2nA5nuuCSETIFn6rVUZdjtcgDFf?=
 =?us-ascii?Q?Mu2RbuGG6P1hmjZeoVxDrRLI6M/FqGfWxjKxQ78JXf3DpjAbmmEoS84l0pe5?=
 =?us-ascii?Q?alH5ThhiWeZkK5/1jjcW48AdcUPvSBrymxwFVe3iU/VJkhSCkQPaW9fstpFw?=
 =?us-ascii?Q?DlRx3wDZauIqRqjDGugIULlKXHv3luo/frCnJMsc3VtXdNuCALSIII5lvvCR?=
 =?us-ascii?Q?KDZ/CKxrqxxQ45+zD/dF8Jz/wP90+2jaX+/VWL3YRiv4/6Y51KVUJww6WNFZ?=
 =?us-ascii?Q?ncYux80JB60rm7xErtTA0Bxv5CLL6haPWA7KXUlmi9uuieFP0YBf2p0i0Ex8?=
 =?us-ascii?Q?Tt4SQE6K3WPPF9Ga6i2n1J6/LRM//UUNUfvW3WRe1amEKPGO/59SZY5uSEFu?=
 =?us-ascii?Q?CqpGiJ2PF7gVKZf1YxfkAZpg6gvZOZ7d1zF822GQ2kv23fhFc/sZXG+vZFTc?=
 =?us-ascii?Q?ypjYJnNeHNApFCTf0Jz/Nz8724rpLJgk1zhVV5AnkOae2ZvR8iXBCKD/f/FS?=
 =?us-ascii?Q?amHPeZr2xNGFkUgzYQhIofvjFKAo99MHdShfgS+6oYHIduPS1wDldJgh0Z0a?=
 =?us-ascii?Q?IYhtZ8ptJTf1KeDmsl1Rc4Tox3J/qcZQZDMVKw9d+M+pa2LfcUDfPTU6rlA3?=
 =?us-ascii?Q?Nwld8St3tnoQ4Z49x5LEAoOcnGYuPUKFmJGv97eu16gV4Gf89oA/ReQ/UKU9?=
 =?us-ascii?Q?u2JpmlAiW4CxVwGaT/buq1Hg15dUnTZlmKH+vvfd03RF8u2GjtR8GNRHpM0s?=
 =?us-ascii?Q?lD4AV0rcttTNtdCQUAOX1SFFRqQ2qkeJPhrqneNlg21UdVNz8RX7LpNkp8M/?=
 =?us-ascii?Q?yf+d3PSdc6XNk0dqv12I2UlOI7CmOH66O63SLSEHqZwXEL432PMdv8oncyFk?=
 =?us-ascii?Q?Cln5pti40E2HqZQGVDH5qlSlWrN/y7hAjpccqvW+FZgr8qCNsFPEuIoiFnmn?=
 =?us-ascii?Q?qTIHDBdOKX3CZR8Z5rGHcC384uHcLXeYWLpt4sn4jWSM/Qkw1Otni7ElWpKy?=
 =?us-ascii?Q?rx+lt9zD7llfXYQ4W2brgXs1nCkxzfzsLM2RReV8vctNtnbMu1vKVd+w2f6d?=
 =?us-ascii?Q?v6o/LcgvYrIVreE2fGki1L5izjW35YO7GYr7Q2GbGaDOuJCndgXLTTXi8sVD?=
 =?us-ascii?Q?lpwY6wOFtp5sfcf3CCu/6k8+zA37wkDRaH9Go2hgm98QYfsPdwXzqMzi5ABD?=
 =?us-ascii?Q?roB1mcf0pM0S06c1yPPQMMzNriuy7gAVzMYSE/RaNgMVJ3nH+cNFHChbaY8S?=
 =?us-ascii?Q?iB2syU43eNH9M170IQXnm5ZsIN6/8x0s0M+kI49jTP4GfMZ38bc5PuCDHFF8?=
 =?us-ascii?Q?GJr5esfQl36+QM6yhoETtQ7CIrAqT5QQL8VIq1BUigLsY6ZRyj3twGIfMYHt?=
 =?us-ascii?Q?WnEsCvIfFR3VAx3iUKUiCIiuyGWdmp/XBddsRFI4vd3kW9cOw6fzVYWEjmVy?=
 =?us-ascii?Q?FQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c07cf5e-9d2e-42c4-03fc-08da6f0d894b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2022 13:48:35.4843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vB6JYg+ArN3K99PMNR0+zha2jQCizK0Z2/mEPYZgdRVsgQBbTZdYQGJGlaN+Bx6EKMMIsB6r7q54Zz9Yh+j3xRO91FNjUh89AGPPQsP14oU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1529
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Wei Liu <wei.liu@kernel.org> Sent: Tuesday, July 26, 2022 6:09 AM
>=20
> On Tue, Jul 26, 2022 at 09:15:58AM +0200, Joerg Roedel wrote:
> > Hi Michael,
> >
> > On Mon, Jul 25, 2022 at 05:53:40PM -0700, Michael Kelley wrote:
> > > Recent changes to solve inconsistencies in handling IRQ masks #ifdef
> > > out the affinity field in irq_common_data for non-SMP configurations.
> > > The current code in hyperv_irq_remapping_alloc() gets a compiler erro=
r
> > > in that case.
> > >
> > > Fix this by using the new irq_data_update_affinity() helper, which
> > > handles the non-SMP case correctly.
> > >
> > > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> >
> > Please add a fixes tag.
> >
> > Where is the change which breaks this currently, in some subsystem tree
> > or already upstream?
> >
>=20
> The offending patch aa081358 is in linux-next.
>=20
> > In case it is still in a maintainers tree, this patch should be applied
> > there. Here is my
> >
> > Acked-by: Joerg Roedel <jroedel@suse.de>
>=20
> I can take this patch via hyperv-next. This is a good improvement
> anyway.

I don't think this patch should go via hyperv-next.  The helper
function is introduced in the linux-next patch in the irq/irqchip-next tree=
,
so this patch should go through irq/irqchip-next to avoid creating an
interdependency.

Since the original breaking change is not upstream, do I need
a Fixes: tag?   Won't using a linux-next commitID in a Fixes:
tag be confusing?  There's nothing to backport to stable.

Michael
