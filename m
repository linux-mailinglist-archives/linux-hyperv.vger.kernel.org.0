Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF125223AD
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 May 2022 20:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348799AbiEJSTK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 10 May 2022 14:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348637AbiEJSTC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 10 May 2022 14:19:02 -0400
Received: from na01-obe.outbound.protection.outlook.com (unknown [52.101.56.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8210C27F10B;
        Tue, 10 May 2022 11:13:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f/b159S7xicaxq17VJFUgL97C326FH2ImyILOXj8IIB3j6B0HJ77ITx1LtX0vOMFyGV9oIljkOO9gfdU5J+uAoIJNeNTyBpadYVsx5pqAfkBff7VYOw5kHajFNXDFlzOnez+BU40GHbNhevpfqqdtSt2iEB7ug5ynDPldibN0v+2RewELhBEGHdHj2forejN8xnmAshI10RO0l99UxSvUWe8DTSHU/MsYG/Va6i4wD0iQE3MmX4fqGbfaIAG90Kt2ugeo7yvka/+014un7OAmOK2CwfETQbH6efcC0QtjS2OgfJHYxcNNv8xakMm8csW7JhVHEXN5UPwr7I5EAbYIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Dobz7mea10UT+rCMEk5VXDEQACtdwPYJJChZ/pBctQ=;
 b=h0fUn+tIh9iGneGnas7RbPbQ+pBIOrsSDOclSV71dg77cdNbk8irXkMpMkxDO/rnO7mAMWgmn+kJOAVocDTnIg/jDDE1yv+0jy9B3pXa16ypiBkeyBl7+UOSAW/Ucx811Zo2FbIHN4D9o6uAQPEApgEDpOQ0Px8UMFMOZE3LWTnhUjFSkgbKMsRsCGrzSKq8+vzYBwVfnj8rRcQFwwETTapVDKVvUZg1CetV/vF9SUiGX5TTZUZ3rFPO0ddJr1gQn0AOnXST8FOvXspzW73U0EEfIsmrqphPG41n4jj6NXZKls5dj4aQ2emKI0uHB3I4L3Sc5YTDKzqPYoXSePtyZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Dobz7mea10UT+rCMEk5VXDEQACtdwPYJJChZ/pBctQ=;
 b=NLNOSfNqN48VMI64jg+7xIBMdJKKraNLuybD0CHYRuVfSo0aLyom+gpKelOLX/rrLI8NP2P2wtsRDxJOhFMjQ+KrfWF/bHmDbahwTtNCMQtvcUe23t+cnO/dehmS+2ZWI2Om+xD2PTDbq6CHz1aeZ8CT4nOywebS7P8xAwwB704=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by BY5PR21MB1425.namprd21.prod.outlook.com (2603:10b6:a03:237::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.3; Tue, 10 May
 2022 18:13:33 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::dd77:2d4d:329e:87df]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::dd77:2d4d:329e:87df%7]) with mapi id 15.20.5273.004; Tue, 10 May 2022
 18:13:33 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
CC:     Jake Oshins <jakeo@microsoft.com>,
        David Zhang <dazhan@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/2] hyperv compose_msi_msg fixups
Thread-Topic: [PATCH 0/2] hyperv compose_msi_msg fixups
Thread-Index: AQHYY+7pzPi4deY6dEe1T1/467S4HK0YaiIA
Date:   Tue, 10 May 2022 18:13:33 +0000
Message-ID: <PH0PR21MB3025EB3FAE7EA7365FD2D7B6D7C99@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <1652132902-27109-1-git-send-email-quic_jhugo@quicinc.com>
In-Reply-To: <1652132902-27109-1-git-send-email-quic_jhugo@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d2d7ee2f-ccef-4a55-9b20-8ba064b91bd2;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-05-10T18:08:49Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dfb19eca-cfc7-4634-3069-08da32b0cb70
x-ms-traffictypediagnostic: BY5PR21MB1425:EE_
x-microsoft-antispam-prvs: <BY5PR21MB14252E81044FF57E4ACF0AA3D7C99@BY5PR21MB1425.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JO0Q5idaWHgv48HzcTelyYblwZ1v2nQCewNVonWRqoUQIcH/U5Fxx8XMPqyb0aYeHjIDcsdLW4GYfmRakL20SKt1eC8C5sIC458Zw8EQQEqrSnIRZluhi7fuml4EMDk9boTReofcD61W4y350c2jWWvctNGroYZDUWSywL1rROGcixbbQayB03FMu8nWl8dWka8OMvJNDp95dLVRAg5T5+z3QaO5K6ElQ6jbK8ffgd6qIjYLE7Wq3DOiNhp0tNuO++NzRg5taUIsGso89gOlPkhyws3itUyM+cQyx8Gh5EhPUP3YgCYb5egoxbEhIdwkxl3imbRkN/kHJ+q/CjdphADYQDVUIhPEVAcEMHblq5tJorqrfANNq9QZyjkpuWdDT0ehHxLkC2K/FI2G/TF5T6zD/+LlD2Tc90852yBmHTebx11sf6InrgFwNxnmA7TESLgXV6CIriobWBRJvBvzXofB/RND5B2MAFZFTo1vlB9bsK9GPvuCDEu4/tB0Ev6MCCGpIQfV6IvtcjwiFBldd4945QVMqWa9riVB841G/eoOghIwamugHew4p+hu5Ee/G417wnm4e3UMBTeDkFFAs8BCpOUqMsXsP+x6iX9QlOX+wn4yh2ka62bmFuL98y0mHNWdGvwb4YUjHJ0c6vkIjg+LAsy5uIH3/OutZLuj023+N/hNSbtKaOFUMiVP43C1vV6knLFiF4kdw//dKI+v+RmIHmtt22BBOXOgizAlNYsz8i0kOJUzQg1TzgdQuksMNT4dDo9mZ17FlYiyTUms6g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(110136005)(186003)(8990500004)(5660300002)(86362001)(6506007)(508600001)(7696005)(33656002)(38100700002)(64756008)(66946007)(66556008)(66476007)(66446008)(8676002)(4326008)(921005)(82960400001)(52536014)(54906003)(82950400001)(122000001)(71200400001)(8936002)(9686003)(2906002)(26005)(316002)(38070700005)(83380400001)(55016003)(76116006)(10290500003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZLEEzLmVD3qiZ+AZEb5OLddlIshcQM2WLug06ZtRCrDaZyRHn8WsvQN0e/+C?=
 =?us-ascii?Q?c6YbGZAa4or4kct7H8ftukMuiX3879dATB7OG1FbqsmBXZbujn27epwmqVsd?=
 =?us-ascii?Q?gfhhFa1G+wc+gcBp8m5L9Q/Hbj5TuJYwaoEN2erESRaJe7dZWUy79SPaVGtO?=
 =?us-ascii?Q?MGRVuwTUNt+LXwD7M82vf9MMI1hrVE8ZsrxtYIfGVHi6VbyO+TihFZI69ajn?=
 =?us-ascii?Q?UiTLbSFMhD2+jhmUbs7sgOFwUC2MKq+EHFK2EArlpl42WuJSUR37KcZyFUX5?=
 =?us-ascii?Q?AvGGrvP3mwjnMSF+sx78P9rqPeqilLtpoIK1uaoaQK324xsWTyx4PbVIj6+m?=
 =?us-ascii?Q?EZRWFnvQnVKlbrOQxdKAhp6jd4HtOYUKP9HDWr4JBMc6E3lDg4PPc14LSF5y?=
 =?us-ascii?Q?JpW9GVaOxhyLW7MNSnheRjAgbNSoqyLm2LuYupK9oXAlATw2ZTb9f1vlPyBw?=
 =?us-ascii?Q?8PQ6up993o/HdiN/ca0V6YvNUEvkQ9WoKTNP67uxiLiOCimaLSXdssU/0xdV?=
 =?us-ascii?Q?GDlp2TOrpKRl4thgNlyCzCkxvpOf+UjXnFcauO+U0Ic2QaJFFW7eJ2no/5Mo?=
 =?us-ascii?Q?cPl1JJxGc5UdFblisVa1vD3U9GCCj8/NT0d6SFPb7k6WqrImA00TIw+FD9Ox?=
 =?us-ascii?Q?Tpw+t58GiK30/m8gSvQ9oUmQvuU+iaa8rNbfj8jN4QSpG8uDKWFmbPcKutJ0?=
 =?us-ascii?Q?1f2PhnqZuXKgigCqRpfmp/ChjEqth+ahpU7oUlj7KbuzWvDHArn6Y2BrvPK9?=
 =?us-ascii?Q?3Op6rfTdvlDheQwKt8ub7y6I6KK9MESY3P6i/0mtMJSBelraLnte1pUKXVVY?=
 =?us-ascii?Q?z5K/yZAuB+oZh8dQJcTpO8Zniyuun/Kj0jLT9V098PLAPPoRLydYZ5OB0dsm?=
 =?us-ascii?Q?0iBoMRlCJV8/gnbjXVJvd3Pyqhn4FupC9XdLPv6acMGIxECCnQ2Mi3Q96esQ?=
 =?us-ascii?Q?Eb3ZkdULILFYnIojnlHhbND7UhgF5VmmEt3XmMc7kDxuhS2dNrSkH4iLkgln?=
 =?us-ascii?Q?vrvX8dXDH00RL4Ao0Ra7WVnhDJPHplmX5QsviYUDshng/LkfWOEcCHdyVSRo?=
 =?us-ascii?Q?egdi6FujL+vEXKIH3pXQ9C+5/pa6wCsmz8COa4jIyQPs94ZRZJS/GkKPQ1Q/?=
 =?us-ascii?Q?XW1hhtM1CoB5Ry8JDRFD/W0S76vlFupX/MNgvbB1cHh2EmUevh4rL/oHy2o3?=
 =?us-ascii?Q?jO2PKS75yBWUVE5HYE4UsTBgK4YSzmCPFDzAyI7bAngoxqKmMZ0Jm7Xpiz/3?=
 =?us-ascii?Q?fPbxBuTP6V7nKBp1FnALuU4OhxlLDbHOohSOf7gvQM2bwrmyDu0oSh0/jf30?=
 =?us-ascii?Q?XeV7RlBIXvaZsLakqXaXpSA63198xUB4xotU79pfzUpDzodAKCOurHuH4wkC?=
 =?us-ascii?Q?Ih3DZmQAbsxRnfBUEhDehH9rpags6Ix7bgYArXI0UdaUt+zGde2LHDkWj2TN?=
 =?us-ascii?Q?gHymXufxyGEEannR8/UoExap60YM1X9CGQ9y5LBXryzrMmLopJUlzpP2QxC/?=
 =?us-ascii?Q?lsCpYgYZa/hRAvvrraj+sfn379h7/JC5Wwx4g95UW6a4CrENQq/3nwk1uY0B?=
 =?us-ascii?Q?3QWeixOpV6nmJOjhaoMxgHnt73WVc2reGXdY+ZBc98qjhB+d/fvfZFxQqk1U?=
 =?us-ascii?Q?xhJ7c5h9QktxFz31oGHhd/SqUeenOVvNHg9oG9ZYb5M7xCeFUvwdq0ZEt7w+?=
 =?us-ascii?Q?b6Hcg6NQKz8xADB+2eeL7reYXR+jv2ccPflM4QQRzsMFuRTOx16rJMRkPbyL?=
 =?us-ascii?Q?RIHZvdl1Kx68D0UoAUmhjArAkRL7H8g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfb19eca-cfc7-4634-3069-08da32b0cb70
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2022 18:13:33.4506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RptsCQR2RUtWWar79T2DknJSmrBeIzdQqB0c4XVaDmVT6Weo7ppNzyHIPCyUJmqbX1lort8NMxPTCmPbdulOLSo/FZ4L+3I3oKW59e3clUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR21MB1425
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Jeffrey Hugo <quic_jhugo@quicinc.com> Sent: Monday, May 9, 2022 2:48 =
PM
>=20
> While multi-MSI appears to work with pci-hyperv.c, there was a concern ab=
out
> how linux was doing the ITRE allocations.  Patch 2 addresses the concern.
>=20
> However, patch 2 exposed an issue with how compose_msi_msg() was freeing =
a
> previous allocation when called for the Nth time.  Imagine a driver using
> pci_alloc_irq_vectors() to request 32 MSIs.  This would cause compose_msi=
_msg()
> to be called 32 times, once for each MSI.  With patch 2, MSI0 would alloc=
ate
> the ITREs needed, and MSI1-31 would use the cached information.  Then the=
 driver
> uses request_irq() on MSI1-17.  This would call compose_msi_msg() again o=
n those
> MSIs, which would again use the cached information.  Then unmask() would =
be
> called to retarget the MSIs to the right VCPU vectors.  Finally, the driv=
er
> calls request_irq() on MSI0.  This would call conpose_msi_msg(), which wo=
uld
> free the block of 32 MSIs, and allocate a new block.  This would undo the
> retarget of MSI1-17, and likely leave those MSIs targeting invalid VCPU v=
ectors.
> This is addressed by patch 1, which is introduced first to prevent a regr=
ession.
>=20
> Jeffrey Hugo (2):
>   PCI: hv: Reuse existing ITRE allocation in compose_msi_msg()
>   PCI: hv: Fix interrupt mapping for multi-MSI
>=20
>  drivers/pci/controller/pci-hyperv.c | 76 ++++++++++++++++++++++++++++---=
------
>  1 file changed, 59 insertions(+), 17 deletions(-)
>=20
> --
> 2.7.4

I tested these two patches in combination with the earlier two on
5.18-rc6 in an ARM64 VM in Azure.   This was a smoke-test to ensure
everything compiled and that the changes aren't fundamentally broken
on ARM64.   The PCI device in this case is the Mellanox Virtual Function
offered to VMs in Azure, which is MSI-X.   As such, the new MSI "batch"
handling is not tested.

Tested-by: Michael Kelley <mikelley@microsoft.com>
