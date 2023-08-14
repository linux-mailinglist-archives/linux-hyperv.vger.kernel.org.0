Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B130B77C15F
	for <lists+linux-hyperv@lfdr.de>; Mon, 14 Aug 2023 22:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbjHNUP6 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 14 Aug 2023 16:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbjHNUPw (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 14 Aug 2023 16:15:52 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021027.outbound.protection.outlook.com [52.101.57.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26130E5B;
        Mon, 14 Aug 2023 13:15:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bOVv5cwoN8N5fSyMBXZEyjJ9aaHevPtBz5UFveaieCYuSumpHPt1uE/EWHSmVjX3Hd1AjdyUMo4sjEgpFr7M1U27ADbu0XYO6gxCqkfDvbh/u4RLNwhNcNeB3a5d1G9XdFnTMF6Lo7wmgqEJb2P79YfaUguIET3oAiA6BLxGRu7klnCi7ffkxR89Bs5v8lCNo7YdTRoSFKXLZ7kH8CCShWTxTX8H1ebrwDMFd2o+RAip2s53rfr5UY/6eq8aCAcoOc+dfeZ1Z4p4ZEc8RvdSTri9bWvQLHfnaEehO1GN4FHmoK7m04fvKb3ZFINLs17mMNr6KuUz5VWZk4miIaOYIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bbpEu2Vot+lKtG8Rw+Hg6guhSP2mc4OwCEEd4Zfg0Ww=;
 b=ZCNiV5QCVRuD7eS/ntVxs5FU5yVNz+OxZKod6GZRAnFgtCSfiGUGLnmuW6Qo2Jig5+LJqBhEe52O/SEs5ksOhqOkw9w+icFX/Su7g5hXHA5gtEJYXA2sUJVybMKThDWpaB7b1kwdwvxy3XfmkLevS44EFGlDnB/iEnfOnhY7A0rVNEa4/YNShDNjYnfm9f8XDuQGKu8Phy9a4ifJOsziy9/Zamti+ixMr80qYmCxDdEdjhQG9PxRz8/I5wGUfn3WH4AmPfDP2a4YUWOqvAMIawoPr8y4XkbugsLGY7a0AmZ1qIgGuiFCIO3iFLw/wMrWexOy3jqV+CmayL4gUsRqEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bbpEu2Vot+lKtG8Rw+Hg6guhSP2mc4OwCEEd4Zfg0Ww=;
 b=HOf8Gp8yzJNYNyTEGFUmXyXLnrMNcDMTnILYyhEVAPQXkX7N69eDIxDQdaRqSa3Yfx/YGN8dXoU0D6Nqlfxf/wN2qfenrnkl/8jCrUvw6revnNKO5RlmZepsOIgxzC2pqNbN7m6yFejwZdJaaihGO1D5rSb1YjK/+kF9N03wl38=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by PH0PR21MB1861.namprd21.prod.outlook.com (2603:10b6:510:17::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.9; Mon, 14 Aug
 2023 20:15:47 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::ed39:f9ac:9110:dd9a]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::ed39:f9ac:9110:dd9a%4]) with mapi id 15.20.6699.012; Mon, 14 Aug 2023
 20:15:47 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Saurabh Sengar <ssengar@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] hv: hyperv.h: Replace one-element array with
 flexible-array member
Thread-Topic: [PATCH] hv: hyperv.h: Replace one-element array with
 flexible-array member
Thread-Index: AQHZyRTXFp6yedDvhkSOqIWkI+ltNa/fDEuggAEcmgCACheS4IAABMVA
Date:   Mon, 14 Aug 2023 20:15:47 +0000
Message-ID: <BYAPR21MB1688600B746F8BAAB702A019D717A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1691401853-26974-1-git-send-email-ssengar@linux.microsoft.com>
 <BYAPR21MB16888C4F0D90CB84716B49EFD70CA@BYAPR21MB1688.namprd21.prod.outlook.com>
 <PUZP153MB063512844F0E2FB075214C57BE0DA@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
 <BYAPR21MB16886B19D5E96933B1E9F6BAD717A@BYAPR21MB1688.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB16886B19D5E96933B1E9F6BAD717A@BYAPR21MB1688.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ee73fe59-7a8a-4e9e-b0b8-3fcc6a8cbf7c;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-07T16:50:10Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|PH0PR21MB1861:EE_
x-ms-office365-filtering-correlation-id: c9f35a00-debf-4d58-33f6-08db9d033f76
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dVCjYN/HSeYxfCyc9qpIX7/1yrRAqPdysjOEMC2vtGs3UbkTQ0fy+y/EATGZc6M2daA4BfBBApFVio+RnKqeQDVWySJE9akX8hyYPyRiB0B19IpYlijZWVe4enniTIaoNkX7L6U5/W9glMPVKw0Be96oQc5UkUadL70gP/V02uzL6iJAK4L5a09mWU2i2dTO6ZVnyThZL5jLecI2GhCs97JLTQ8zrw3Nzlw99mXF0eG+Cj6yBl/ntz1zRgcG1uzFJGn54YuRZXc6dyIsyZrPQp4DBP+x5hfPECVj8t7MF01J6eSJz4KowYlfiGdwqI9eLTlhUKlJMvLN9rdGFLDkfHJO7x5Hg66DeO6pPN9Aj2LHDpGXQ1eulR3npQkb+S5DXlumRihR1VR1bRxEv+882tGNCLqTcoskEIlq4nQYkPpC5pjGn+2usLru/JotbLTV4SHvlDNqBoICTwhr2hktzFPqk68P8zYGQiPmVOqGg9eyK/hglgzvxKHk98YurZDtQRICjMtVs9Z6oUHe32X2J2svE3Yc6alkBUrnuwxz5ho+ldo5n4RD58sXpsPX3N0nKkAklXXnuA0MDudXu55Ox4FbT14yX1ZecNZZmNRiH6Syd8ZwH0Dt+VOYvWEbTkuuv/8QzwQ1u6iai5NYKQ5SygvQ0AR7MLTfDcQxQaQI9qBO1Ja3phlSl0x8XYl57Bu/17pjBiVnJy5N/nXn+BsnMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(376002)(136003)(396003)(39860400002)(451199021)(186006)(1800799006)(12101799016)(6506007)(54906003)(10290500003)(110136005)(478600001)(83380400001)(26005)(71200400001)(55016003)(2940100002)(76116006)(7696005)(9686003)(8676002)(2906002)(38100700002)(38070700005)(82960400001)(52536014)(8936002)(5660300002)(41300700001)(316002)(6636002)(33656002)(4326008)(122000001)(86362001)(82950400001)(8990500004)(64756008)(66476007)(66946007)(66556008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2IHE01I7RTknB+sZi4sqx9RfbeM77iwcvjKB31MjfYMHfIoo+97HZD+023ga?=
 =?us-ascii?Q?JlSzZZGAHbO1YsDb/ZNX3ZymPrFrdvwhRGHJCgfoNDDyTFG4+MoR/8wa3l3P?=
 =?us-ascii?Q?NIfTn3cERuxNbTIoKINQ8cehOMs1TOyy/qMATMYoRLTCcvj6YsZg9yjkUQBb?=
 =?us-ascii?Q?lOV0IldyvFrP7bUD3F08zuQYaGQNJ1u2iU1WCExe7NJ2mrS6lVBFk2VpBeR5?=
 =?us-ascii?Q?7b0fF5gi5rixCsQnX2Ez8KPFHQaWqP09kyJ6L2qElcArCZdryO5JXYYrM0sR?=
 =?us-ascii?Q?lxylh/a+4XZd5qseqN490ukjPT3MfpX9uFfJB1jnopdJsN+fPnyc1dg9+aR5?=
 =?us-ascii?Q?7Y82Lj5ZODMFtb1osBeaDMUYpCefd9cuLgfN7MsBX5+IENdhXcWdbNPIQBzs?=
 =?us-ascii?Q?SvdXB9FeknfEGAMsYI2dIIK1sq6jQpoWmlEQbEfdg/JbLpxsnZC81LbQ3vcr?=
 =?us-ascii?Q?fhgEbOfNBuv83vTFq1LCDsa+AxbjZknvw4XbftBahVhwY6DgNDocY5LCIQT0?=
 =?us-ascii?Q?iuu142UE/5wrqL0T19eg0PSz/lHVtyvRaDJ9+Bm3p+X8Zsu8odob0nSv6j8k?=
 =?us-ascii?Q?h/SGP7IWUNLnIiV2EVsuqEHfBRJlai4H2O991tSlXrKOXivQz6SVcycOPiZO?=
 =?us-ascii?Q?HKr8LNEIF1xWE9eLUt/H0sihzaEKnxf5crrELBEQ2yCgggwhWFZSiuUlh36v?=
 =?us-ascii?Q?pE7Ogz6/F1mZaQW2K0JygIupm4R+2TZvEkyxmg4cS/6cV/TrEfXZG9lB1CWm?=
 =?us-ascii?Q?g+CPXFQzkKFT0rpXWfL9+kPg5kWvCgtJXGn/lWOMLvQAhurpJdCR6Ca2DIQB?=
 =?us-ascii?Q?EnvnFKNRYqaWjCIFnomIWS5Ic8TU+y3l+IAHMm0wuuQo3ocxAsr7J18vhTyc?=
 =?us-ascii?Q?be+k++6FU/ebIcIPsss6xJ1Mf5TkZ/e6GBDUuxqSDoDTiPlVPoML3baLU1Q6?=
 =?us-ascii?Q?Ahu6EBGJAhMPRsZEccKY3zyXdnYnujy+S9nunXrfsQXPUTm9uDBiav5USYuo?=
 =?us-ascii?Q?3mSXZ4VkAa0E0IhYTdwuHLjp1xeQV9FYRk0G9X4sDa0PW40Rd1kzandEoDw2?=
 =?us-ascii?Q?Zt0DyHzFiYJADhVJS6w1C8E8Tv+c5MykB+uLD3Z/H/NvIJB0DUiDjvV06woz?=
 =?us-ascii?Q?mtWa4xVdjPPNH+oce9KIU7fwh+pzz+cfLD/fQ/C79lta0mRbYog9hdoi111A?=
 =?us-ascii?Q?fNFwukvCEZuGY89jJTSE8xscar5zpliPqoLSau3D7S/tDJKtIh+k9TGoJtge?=
 =?us-ascii?Q?nxfp7x+OUwwzfL3+rWkBbc1y1oUiaeu0X7efLGN0dHYGct/uNR8OyYXwR0Oc?=
 =?us-ascii?Q?6OBLmEnMzxeSohSVvji25kzJXxwti83y9u9sNPaWuAga621HsHPuGgQ3WkYE?=
 =?us-ascii?Q?7YZyaAFaSAGPK4vSEilpgrqfhrltaUI93fr9bvtyZVs6BAA8z/lN0wU8LFPM?=
 =?us-ascii?Q?FtW/sbqrLHy2LqwSQ8blA7iGprcuoJWUGa4HCquVXo3rjR/5gkT9RJoJnOtt?=
 =?us-ascii?Q?zrQc0RVG4MkwxSKmqGmGedFUKtsXS/1gxiGe7oQImC+AcTrulgGY1CmX2qfi?=
 =?us-ascii?Q?kWcjEEtgopNK+Z3o/Jk9YJhztkSeYJ7fKUx0Zocg1rg+2YW04kMjGV+d7GAo?=
 =?us-ascii?Q?rA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9f35a00-debf-4d58-33f6-08db9d033f76
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2023 20:15:47.8032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rd8sOHkj9x+ezIBUjNKU4zXON4tHJ32qJ8bF+/5qfafR+bRe8pKc8MYE0LT5y3rmW9qATw/D4jT2hGwMcVRM3+UDHvV3fSz/G16+RhwfBmQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB1861
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Michael Kelley (LINUX) <mikelley@microsoft.com> Sent: Monday, August =
14, 2023 1:10 PM
> From: Saurabh Singh Sengar <ssengar@microsoft.com> Sent: Tuesday, August =
8, 2023 2:49 AM
> >

[snip]

> >
> > Thanks for your comment, I wanted to have this discussion.
> >
> > Before sending this patch, I was contemplating whether or not to make t=
his change.
> > Through my analysis, I arrived at the conclusion that the initial valid=
ation code
> > wasn't entirely accurate. And with the proposed changes it gets more ac=
curate.
> > IMHO it is more accurate to exclude the size of 'ranges' in the header.
> >
> > With my limited understanding of this driver,  the current "header size=
 validation"
> > is only to make sure that header is correct. So, that we fetch the rang=
e_cnt and
> > xfer_pageset_id correctly from it. For this to be done I don't find any=
 reason
> > to include the size of ranges in this check. With inclusion of ranges w=
e are
> > checking the first 'struct vmtransfer_page_range' size as well which is=
 not required
> > for fetching above two values.
> >
> > Once we have the count of ranges we will anyway check the sanity of ran=
ges with
> > NETVSC_XFER_HEADER_SIZE. This will check "count * (struct vmtransfer_pa=
ge_range)"
> > Which is present few lines after.
> >
> > For a ranges count =3D 1, I don't see there is any difference between b=
oth the checks as
> > of today.
> >
> > Please let me know you opinion if you don't find my explanation reasona=
ble.
> >
> > I don't see any other place this structure's size change will affect.
> >
>=20
> Got it.  I have now carefully looked at the netvsc_receive() code myself,
> and I agree with you.  With the 1 element array, the validation in
> netvsc_receive() could have generated a false positive if the range_cnt
> is zero.  But I don't think a zero range_cnt ever happens, so the
> false positive never happens.  With the change to use a flexible array,
> the validation is now correct even with a range_cnt of zero.
>=20
> Please add a note to the commit message for this patch:  The validation
> code in the netvsc driver is affected by changing the struct size, but th=
e
> effects have been examined and have been determined to be appropriate.
>=20

One other thought:  Could this change affect user space DPDK code that
is processing netvsc packets?

Michael

