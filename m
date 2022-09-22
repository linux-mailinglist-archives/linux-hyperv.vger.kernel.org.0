Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608075E6CAD
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Sep 2022 22:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbiIVUHX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 22 Sep 2022 16:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbiIVUHW (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 22 Sep 2022 16:07:22 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11021024.outbound.protection.outlook.com [52.101.62.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7FCE6A1E;
        Thu, 22 Sep 2022 13:07:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LFpQm3g4+zfCZCKL9Pz5ppSagcS5U7CdwD2hSbet/Y9qfLQMkkAuL/8t8kZpDEC736Ng3pSXaTMyxNyRmje1MT9ki1SVbu6kaxrzzzNEyIZpDh/7t45USytelWRF9g64Io1rXLGapyUK6UcJv9zgsJ6NNJIAaqdmsyoC7W1xZjr7YfCgcYKl9+lqCXipq8xx/CP0E38jcAcfIlxgKzqi2MEMIed6OOpTHPac79FsqW4CkrhkFkcZPQKORewNMJ3WzMd4qoUyABRCHLJB0992Z03NBfDMUsEW6aEL+M4JgEVu2Uqaee2yBWP6AF0uEIPDRA/SQ5rtB1eo1Dm/pvRvjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ViEdSMbRcri5ZPJJOn7FvxDg//CUHyan0n2DH8gSMU8=;
 b=auyL1U9ES5ocKPfl7EveV9MDZpm09+0HLQkWPCO3jm3efAcn6/79voQvz8i3cbHwj3jZsoXHdexFGPITb4/7xIjnEKR+ybI8xMcDRWtXkOVd/dcddxf1swHcuvEZJ66T0aAFc2yYssOyLFuEcJNbS/VlmgRJA2XigRk6Kn9kS5hTzGjDvdZ2N89Kwn2puVtaTdYYKmbKmzW+O9DGk9CepHWB6db6SK324dwDbe7DF61sm/sgqLx/EtQE6r/XtF8Iwn1vcQ3zsEmFCvCyAf5ZWfY9OedYpwC/1ZMUAza9HhoeTIMQawgQSkPW9alzES9TeIiS7+dJgU6KkuScLr0xxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ViEdSMbRcri5ZPJJOn7FvxDg//CUHyan0n2DH8gSMU8=;
 b=DsX4K0jzRK72tnztt/S9gW3u64heCQMAy7nzsRJCB3BaLdziWLOerB3exGWFq/CYN/NdkabCxYXbtx9E6IemYzL9TRhbbJlDjOwIBkM9f2n66E4aK6C9detEW5OVwXRcrR/SIOmh3zGpyUcZ0XQX65g13LPvjvOJG4LS3XLr1Ck=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by MN0PR21MB3436.namprd21.prod.outlook.com (2603:10b6:208:3d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.7; Thu, 22 Sep
 2022 20:07:19 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::2211:39cc:507f:68b9]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::2211:39cc:507f:68b9%7]) with mapi id 15.20.5676.009; Thu, 22 Sep 2022
 20:07:19 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>,
        Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
CC:     Stanislav Kinsburskii <skinsburskii@microsoft.com>,
        Stanislav Kinsburskiy <stanislav.kinsburskiy@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Subject: RE: [PATCH] Drivers: hv: vmbus: Don't wait for the ACPI device upon
 initialization
Thread-Topic: [PATCH] Drivers: hv: vmbus: Don't wait for the ACPI device upon
 initialization
Thread-Index: AQHYzqeDhTHe4jwffUGdTyhvqrSm0q3r4FiA
Date:   Thu, 22 Sep 2022 20:07:19 +0000
Message-ID: <SA1PR21MB13354BFC68B9791FCE469763BF4E9@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <166378554568.581670.1124852716698789244.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <YyyZLMMiDfExQI2v@liuwe-devbox-debian-v2>
In-Reply-To: <YyyZLMMiDfExQI2v@liuwe-devbox-debian-v2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=cbf862db-4b40-490a-98d2-1be04e1afb21;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-09-22T20:06:39Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|MN0PR21MB3436:EE_
x-ms-office365-filtering-correlation-id: 7f4a41c6-0f6e-4fd8-124e-08da9cd60d9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nx9bxS+5/yX93XmXIOVZjTm9xvUDUJ+xqUG6ANUZwlYcmemEt5IE3dc+y527kxHWbthJVQtbwwwBmz9OjhuU/JDSyQKhQwpivExe19yXGc2KU3mMGEgpnj13J+o/SIMdMY3zFLaiqSESHvPoVEdYaUgiyW3f13klEUMDXLfGlKlhQ2d0+hIcnP7Q76aJj7yPM29NGPDTzT6O1No/WBmcrdXSrcooSzBMJnx2wrFK8Nb31G2cIIWBTWwgYcTAg1bOeDVzp/bS/qzU1Brtcy7C5/juF+ZA7PXC+7/faz476Alxj3iujUp2eQre2o4T9YceIcD94oExZ+2dKUIQh6OUMZO6SWPhezuAZ+q/08pF4y4NBeEi+JrYAEodMnNuWeqCIxGMj1Rwj+AtW0ADYyIjZOgMehF+RN9f/ohR63N1UpYpzdkoIU6J8NPzY3EvigoibFQgFHphdaEW6TBmzb+nOBD7GT3mkVzxsLt3ow+VzegKQM4OrnhzxiCEn2pG8E/bfaYUdLKuCzj6i0tXjDMFa+i5bqUYKiFgyIydooLZUbNswnMdP0oify6ULrkQF1xu+gOjfM7v3APbLiottzXGEVXdStfJgBMJcggPTWkyesh2zAuueucJjqSHjj84tRzsPfyrFv6vmfwW+m1sc6nhWT1tex7U5Xa9l/18Z8z1LimJmFCcCHUWofRSlMW5fbtWlJ5SryrlL/ALgHv5WbyaSXC2GGHMTCl/reYwJ5np8QEiUs/cTD8MbdDxUWzDwQE/o7KKNAbgmgUVRxWgz6EiNCrNUoP2Q4Twk1L/stFSSR/Fu66sCRdWRUPJKVoGvI+D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(451199015)(478600001)(76116006)(38100700002)(122000001)(86362001)(33656002)(7696005)(82950400001)(82960400001)(4326008)(2906002)(38070700005)(8676002)(64756008)(66446008)(66476007)(66556008)(52536014)(8990500004)(6506007)(41300700001)(55016003)(9686003)(66946007)(110136005)(4744005)(8936002)(5660300002)(186003)(26005)(316002)(54906003)(10290500003)(71200400001)(107886003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wlOsA2WkYV0KF9/eb6STZlGZoTCc4jqjIHN1gn9PyTKR87GO/IjWmNnOITeA?=
 =?us-ascii?Q?MV6yIlAhIcWMnLOOtC1iTMBZJ4jv8Va0oQ/do8WRpUfTfFl41R/yDgofW1s8?=
 =?us-ascii?Q?aGj2xNhqM/IIVH2mTHrMS5zYfNQCh9V7BAYp4LmrBN1tZb8Em7wTX44TuDmw?=
 =?us-ascii?Q?l+y6vY5nQT1i+9y9XqTAh5CRqNNx8lGnxJpkp7xh+aTOlbxiTFif6k1X/Dct?=
 =?us-ascii?Q?gqjq7xxvXCeV2OV8YUHqvER5Z1j8pfE2BUq4eQ9RixWf+KrmDXQ5XvBSx/i7?=
 =?us-ascii?Q?gAAKrfFZ0Td4kdhzD1wJ9vu6eUhAKIqMrtrYLARSWr6lJi/UeWtiDKxw1diV?=
 =?us-ascii?Q?h/yd8VHh79sjpF+V5pobIkm8mHH5gt25PMkVSokDUnrYUh7/QWeapcGznRqv?=
 =?us-ascii?Q?Mc0Yln7WQSazNn41yuBzzaCiMKbymk9jc98r3bnSysnOdU9g8SEVZhwCGMF9?=
 =?us-ascii?Q?HaBqCjCQhXWnjdg4cRzMcnJM89eE2p4/hGc2cTpsD3mhAbw2RteDLy4NtiwN?=
 =?us-ascii?Q?mJL8hM6JFoZvrM7QWs9yLrsmfQLz9qsK+jKFhdIKXx02IXLkvKg4ak5Lq7SP?=
 =?us-ascii?Q?FxckNcX6ZCmGDcam3Nrz3CvPGAX8Oo75NLN/XlJSWbITU6IMZ3s7U7N3ajtt?=
 =?us-ascii?Q?XiHWkPKiCfadWycGSRE8TNbsnNZtjiEcf5W1AJrQEUCSPawN0mB+IUUTriCF?=
 =?us-ascii?Q?FOoirVH0kLKK7IACx8m1mB/qHtYpiswtaw8NFG/SxjlfnPQhGDNYagTbfyHY?=
 =?us-ascii?Q?g8or8xvfTtr+HKQR6hIg9ulBcq3zJarVdV9E073t9QJSZG+zxPgB4q58VMfI?=
 =?us-ascii?Q?C2XOyXDzxjifRPE6HHNkF8S03NHzZcmttNBZSRwSeoHNEa5ddrCt/+1dqJe8?=
 =?us-ascii?Q?u92wG3jVnN35lV9kMFqADzG/ZiLFKuP6iJA10+nzx3MbxKpgXY+nXTvXaGls?=
 =?us-ascii?Q?sVbVXmFlDBK1qoOR3/9IYE40b8UkMzP52FsAIev/JVE6WX4PT1o2WFMDqgA0?=
 =?us-ascii?Q?+hP9NT2Kzxfw8mpVY15EzoXLvLjF0pD4zC9BeZ7Z84l1AQ7IF6y6pk4o4oyM?=
 =?us-ascii?Q?zc9rqhRSuAWkRiEe3PozPSorNOcmhnpGtktCBdiYamMi8rJAy7MOZH7tBjdM?=
 =?us-ascii?Q?Q7a7JN0dQWpK6LewoAdly2XCynrcq9n0XcMxvNoXa5GasavI6R4ueQqxElmo?=
 =?us-ascii?Q?8+SLhxkuohFqhItEt/tst2Wt4qcjiJJjfzKrlcgzhc75ItaeiGuCJsZ3dnOO?=
 =?us-ascii?Q?yQGrw9+HQKXFSwwvR+q6gV9y0YXDgL50e4Swnkk5ItcAvj7w2HN4vX5tuXSp?=
 =?us-ascii?Q?6oGbHqtJEmryQBts2SAOjEu/MbUXg+yvvD76Bg7th11nHZQxlJW12Ye9xlkI?=
 =?us-ascii?Q?Dj+F+DDsufn7u4qLtTQA98COwi4FQ/MQIZY9pXRlWx9kvq3XFWlBV8m310tb?=
 =?us-ascii?Q?eeb07SOW8bnAygzAWt4ffdnTr48wMoJ9eg0WkQOO5+Z6MZ2zd9k8Nbo6395L?=
 =?us-ascii?Q?1Ou+iNPG/CKOc5MDxvNmhMXRz3WhxqxFLZhMGvQTO+iuWCGIQBtad5id9tlh?=
 =?us-ascii?Q?VN1aHIc36GfaUarHZDgNR51suddPLS64QT6fFFq7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f4a41c6-0f6e-4fd8-124e-08da9cd60d9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2022 20:07:19.1169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vmey7AI8BVdImfab444yLVqQlXpdBhpF++8DEurq9bKzxTb3CIGu5/VsCEiuZw1uqS+DAIcnM6DTA1AllDL68Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3436
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Wei Liu <wei.liu@kernel.org>
> Sent: Thursday, September 22, 2022 10:20 AM
> ...
> On Wed, Sep 21, 2022 at 06:39:05PM +0000, Stanislav Kinsburskii wrote:
> > From: Stanislav Kinsburskiy <stanislav.kinsburskiy@gmail.com>
> >
> > Waiting to 5 seconds in case of missing VMBUS ACPI device is redundant =
as
> the
> > device is either present already or won't be available at all.
> > This patch enforces synchronous probing to make sure the bus traversal,
> > happening upon driver registering will either find the device (if prese=
nt) or
> > not spend any additional time if device is absent.
> >
> > Signed-off-by: Stanislav Kinsburskiy <stanislav.kinsburskiy@gmail.com>
> > CC: "K. Y. Srinivasan" <kys@microsoft.com>
> > CC: Haiyang Zhang <haiyangz@microsoft.com>
> > CC: Stephen Hemminger <sthemmin@microsoft.com>
> > CC: Wei Liu <wei.liu@kernel.org>
> > CC: Dexuan Cui <decui@microsoft.com>
> > CC: linux-hyperv@vger.kernel.org
> > CC: linux-kernel@vger.kernel.org
>=20
> Looks good to me. I will wait for a few days for others to chime in.
>=20
> CC Michael.

Looks good to me.

Reviewed-by: Dexuan Cui <decui@microsoft.com>

