Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A44641FC6
	for <lists+linux-hyperv@lfdr.de>; Sun,  4 Dec 2022 22:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiLDVRW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 4 Dec 2022 16:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiLDVRV (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 4 Dec 2022 16:17:21 -0500
Received: from BL0PR02CU005-vft-obe.outbound.protection.outlook.com (mail-eastusazon11022017.outbound.protection.outlook.com [52.101.53.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED1A11C07;
        Sun,  4 Dec 2022 13:17:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPcZdlBLgG66gm9SZurWPKHoaFSE8ERahtHRnAUPUaYRVhvB7mHcivokUwODLrt8K9A3Y3d+x9TVOXLZWuDDOfbxLv9v6zzhSIPYZpn//D2YpLUpCNJplRwFhh88EINWP20cicv0sxbqo6jzdT0HRIO9cED6i843nSgSh1vLSnnYF77d/Ne54xetIDasWdOW5zyXeOpnn3QblsOEf/0gR1blFJgT0z47laLA+buBH3Qc8XHbD6lVd+gxSqQu16+Mkda87iE5Pdt3x+qZjyBGXSGcfugCyi92YXMTpnTI1mK3/y2CccZ8+P0+LJbZR9Z3ISuYs7EaS9zRdZcjqhFBgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=atqMNlWX+T+eqfwkAYlvlYOcevIm2TENAWd92L1IQQo=;
 b=KryGD6UDAssKwc8LzV+DcsZrmfgoN51jYgUl+45UJtjI1iMkTQSaoqzGxsxMrJL6hrfbLDZKRhoRg99jr9ZNx3yG0qHif5SEdXYQZi9WpgEhGbQlIuFVCBApsk6LMsvJdJ9+FU/JcUqEeFgH46g4tr3corXfRtXQLhnMrjCUv5CXTTa9ONSbTUOoZKUQkfbFCkHwFAusV9z3EpFhVKgCGUkdwLObPcoROTpVdz6/dnPzKfOPeFt4G2/Jj/y0sMC4LCsX4v5m4egSs+vDYivyd6ELspGXnAXNPPvcDNJLd4Zwsyr+s2junjOaObtCpqvCgV8Bpgolcs6MWhN/I+RcEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=atqMNlWX+T+eqfwkAYlvlYOcevIm2TENAWd92L1IQQo=;
 b=YhGVR3TrBAoayVgvuBJI182vY6Ac+gemiQERuVCV8ii3OzeqzbLbPKkt8ulLjW4oz/03uCb3uH+EdJGzkc/SiWxhKthqAgmwmxvWvgHNEP5cRqFWkQeDh3vQb/yrmYE/pueE3gSVpmsK9ow0ITAeJFE/V06xt6eXYAg8HTIlwLQ=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by CY5PR21MB3759.namprd21.prod.outlook.com (2603:10b6:930:c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.3; Sun, 4 Dec
 2022 21:17:16 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817%4]) with mapi id 15.20.5924.004; Sun, 4 Dec 2022
 21:17:16 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        Long Li <longli@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: RE: [PATCH 1/1] scsi: storvsc: Fix swiotlb bounce buffer leak in
 confidential VM
Thread-Topic: [PATCH 1/1] scsi: storvsc: Fix swiotlb bounce buffer leak in
 confidential VM
Thread-Index: AQHZCBou05HjnyHB20+V5Kk6vu6BPq5eOq9A
Date:   Sun, 4 Dec 2022 21:17:16 +0000
Message-ID: <SA1PR21MB13353917AEDF678F5D3204B4BF199@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <1670183564-76254-1-git-send-email-mikelley@microsoft.com>
In-Reply-To: <1670183564-76254-1-git-send-email-mikelley@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3a25623d-b338-4019-bede-5f023d1a5ed6;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-12-04T21:14:49Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|CY5PR21MB3759:EE_
x-ms-office365-filtering-correlation-id: 16b2fa96-bea1-49a6-d30a-08dad63ceb74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 95mB5vXfLNxj2YlxGM+t5taMlBlUpV0MsPQy9ewpm3u3R60yHPEjX4QRdEGTBGRWdls/w/2e2cYeJXyDuYmQ4B3EtHiP/YXniPNtkv2WQf4CpTlB7aF29srdNGIs4Ph6C5HuSDDFsLBZK6m/kQwR0G3Yh8/lDdIzYz7HylWKTW0BAoPCO5N1eoFRAb8ScSe0h5TiZHI3dInJbJu8SCiYfJYVRo7cm1y25RxGnSHo4s1woCyeT4pEvBkeAIndQ/ZDcdk6kZPkmp69gISggOCauyKqhatLWCbTf3EJHFVlNAGV0JLDn9nfLubcqFRq4rQTT2RqcrQHjCiI5DiQijKVjHepX/i6EmmRGHp+qx8VF/voVGhRde6ZA2efv1dUzOZ8FTfGMaYfYfNv0KWPZbsJolJ897mVtpU/N0VVJhF351vuuh4DEpGOqpTsFhRTcqfMiCE9Q5nnqh+7aZFjnCsXJby38nbuCbxcoh9E1yUaTcpMN0Tb+fZey4jXzNVgP2UQg9JFEacMTu7gnvdICEcZERwQ5CsusYyjl6YhSu4UaRk33/89MM4PrvCzpPKW7hjb0OearAA2jYZjQhBs6kWJU6ZAJxzEg1AwZT4efCz+5zErNart8gmcBjCUC425laqkJkd9bkilNNnNPICp/dwcfU4CnsKpTPhY3EbeoyW1fA3VLsIB1CveGS0O2qAYTg6AP/DbqB9f/9Rv5MWAaPyGNCvJLhILYSH3enL2gfY9ge/4P0FaYG/KTerSNwY6rt4L
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(366004)(136003)(396003)(376002)(451199015)(38100700002)(82960400001)(86362001)(8990500004)(41300700001)(5660300002)(8936002)(2906002)(38070700005)(82950400001)(122000001)(83380400001)(33656002)(76116006)(66476007)(66946007)(66446008)(478600001)(66556008)(316002)(110136005)(71200400001)(10290500003)(55016003)(8676002)(52536014)(186003)(7696005)(9686003)(6506007)(64756008)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RkfnvFALipoV3XgdiLxM/AXuR14B+O+fTlize+XvN09iU3BMdp4ynwJ6DBeu?=
 =?us-ascii?Q?XR6kK1QOGzhAHt8ER1Sj5COCrwxuf0YT0W4MN4wiEf3t7bzcd5SYNkWtILu/?=
 =?us-ascii?Q?JP+4CUXX7ef1MhPqYzX0qJQmdd4g8s3oXcF0i4XHPkuFHoeIwyVrkfLLh9Wa?=
 =?us-ascii?Q?MLJGdLtZybVvOqgbWZUdY4K5th/lERHLKNXVcUXh79z6t+7d3nxZMVTZF48M?=
 =?us-ascii?Q?9EYNjjySdaZQiOdCAVsADWFQpQsHwnf4tpyX/hpU5mdPjEaFmpExyfSIyTL3?=
 =?us-ascii?Q?Bwnfc++n3cc1WK9VhdzHO6/ZG+oLPdgsva/mR0OQWiG8Onwx/+oClqIYvRTc?=
 =?us-ascii?Q?HTgPbzhS51vp5L4PtnYnvJHD0r90zSjP9JC1ojcuRSIr3QlHWkufGTehCu4R?=
 =?us-ascii?Q?pR7NxI41cfBpklEXc6t3/cqLAnmk9lmIM1BHnXIsrstAc1I1jlc3Rqld0mlO?=
 =?us-ascii?Q?VNQblFo5QbD0eiAUW+wA1QFOLYB6yS+aizoMfZO2MrZssS2fQYV/jzl8trAZ?=
 =?us-ascii?Q?nnmYY/REgl4Fifz+PJyHeWaQwGR7fXG6lb28XUYebxIvx/OOUNHIY6cvLkEb?=
 =?us-ascii?Q?L2MwTB6PRjG07EiccWTXTP4iTnBTxiReFocFxEcL4c6guk79AYxBsTouj5sJ?=
 =?us-ascii?Q?WxHhYxI7y8OX3fvP6puI5QZ5w/mCFO9Fcx4JluIqQ3SyTzcvomlbdZt5PGXx?=
 =?us-ascii?Q?kblCzKdde864uOXTaPJoYD8bdl7m6pIBVj1wXifXwFWZaG50a/zZL0S66HCr?=
 =?us-ascii?Q?3zdEG8rQNj7itdOSyYQPSg9CLmUoguEXmcxknUs+8Amv0KUrp47DlEsiiygB?=
 =?us-ascii?Q?f6SXjQGtNDzcCYs/WYigSft1DIPWn7tj3tdSwD6UGvAh8vro+GPSjlgR5vyV?=
 =?us-ascii?Q?SYcLZVtW5uS3V198Qd1SbqeCtVN/ERW3kfYHr3OTe59Ql6oa+NoZSMT6z+Nq?=
 =?us-ascii?Q?7AEQtueaUcr3vTnffGYJJ8xoqxONHci1o7vPWg4e9HzleX70n0R0NtINRwuB?=
 =?us-ascii?Q?X4/t40C93TCn1y62Sim+fMmc+QX+7A85DTPqtjhXZGdG99eoVO3nw4Ii5ICp?=
 =?us-ascii?Q?qmguJG9ZQ2P/gRPmlyBRd8uqejz+saFUHX5eAipkNPVLFpDqp12Vvk45WAbb?=
 =?us-ascii?Q?zR0QtZ3HnRwIdmmipCn/DTtA9JNC6sHb0qQHe8YZSESyl8fDul8PKj4CDJc7?=
 =?us-ascii?Q?kqhDGCv0b72L5xKpvn3M4550l1Uj/WRUtJ1iz/DXyK65tP3QXriWGf5avsfb?=
 =?us-ascii?Q?FVRa5c+e5O74wMPkljjNxI4JKgmyN6a09YTuYwJtoGFSAUA5d+g3MYbBFhCg?=
 =?us-ascii?Q?D5RpGCLaG2/UfoY+SCEpA6aHmDaonKCwlmRDHomsWOZAFBc/YnGKLs+Dalx9?=
 =?us-ascii?Q?m3ZSPZaGsPiHgYiZJhe53HDOrshe0MZWVIrxlnBRKGjteHj5T1fhmGWY+oWc?=
 =?us-ascii?Q?0byl3mank64eDi4guB0F1YrjwgpBM521htFyDTeq5vyBBg4VtX909b8lFPWr?=
 =?us-ascii?Q?Hd5EUFXCTS/TaMuX34wjKIHv4jA7GsFQ5/0FCrp7vffnouZkMWNIy1B3fgE7?=
 =?us-ascii?Q?7aH8aFmtvwd+3ioaMI0HTFnuVmr8pnrH1gLTX+n0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16b2fa96-bea1-49a6-d30a-08dad63ceb74
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2022 21:17:16.2717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tUuMlbElI7XbtWVJqujXrBK/j98U3HEfcOVt6wy65pxZyKI2hR4r4zMOkM07QthwH5BHcXg8PNhbNX8j/O7Jsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR21MB3759
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Michael Kelley (LINUX) <mikelley@microsoft.com>
> Sent: Sunday, December 4, 2022 11:53 AM
>=20
> storvsc_queuecommand() maps the scatter/gather list using scsi_dma_map(),
> which in a confidential VM allocates swiotlb bounce buffers. If the
> I/O submission fails in storvsc_do_io(), the I/O is typically retried
> by higher level code, but the bounce buffer memory is never freed.
> The mostly like cause of I/O submission failure is a full VMBus
> channel ring buffer, which is not uncommon under high I/O loads.
> Eventually enough bounce buffer memory leaks that the confidential
> VM can't do any I/O. The same problem can arise in a non-confidential
> VM with kernel boot parameter swiotlb=3Dforce.
>=20
> Fix this by doing scsi_dma_unmap() in the case of an I/O submission
> error, which frees the bounce buffer memory.
>=20
> Fixes: 743b237c3a7b ("scsi: storvsc: Add Isolation VM support for storvsc
> driver")
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> ---

Reviewed-by: Dexuan Cui <decui@microsoft.com>
Tested-by: Dexuan Cui <decui@microsoft.com>

I hope this fix can be included in v6.1.
