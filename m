Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E783427D6
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Mar 2021 22:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbhCSVbG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 19 Mar 2021 17:31:06 -0400
Received: from mail-mw2nam12on2103.outbound.protection.outlook.com ([40.107.244.103]:22849
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230435AbhCSVaw (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 19 Mar 2021 17:30:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WVV0U1dSNmULd/rSyAzeD0FY8ghbb/V3IR+ZIKD+kK0RtrSBOv2UtEaj+LThPOxO33/vqQ6HR8dVvJ0MFydEsPNYpgduEoDfS1gLh/mKrmzCh+hmF87/S2vHuywlm8CNNJ55dbURVsUxXAqIHTM9eKfev4weKMYAYHHjxj92AaCymgVvh8g+qTaO6UX7DngNeIC/KQaTqtPI/Tb4pH7Y2TSUCqzZMd5ORtEebk432j0v5Fshba4fUR70jEEjZel96TnetXBXnu88+O7WMFO8rxZN8kv5R52eZ1HVq65Pvg+ILfP+l94M5pBsz5cAGTWSnwvDaLWGjF4tdShTly4DgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWDoKMjaC1KhBwBV723U2LQC0Gd0CWE/iUHXaMM3tVE=;
 b=FKn3/Fg8UK4U96jkh9cFm4iGa3Kir4sodoLbocT7I165+dSF6FZIki8t9c9Jp5XvTZ1u9NFDQPCO4aydpc2YLtKWsXFDP5UBgM2Jqmr3OQWzhCV5r7VK2SfUyQsDnw0qQ6ntWXWlydRJWNg+E+5Ie8nSuUZnVqUTemMDYjQsgPP5HjbaeBhtRIh572q+eGF9smzsCx7FEqg0usglP4+t7uV7zqPxjZPBJzQ7+92A3QE/4HKkEpFuqqV1K3YjrLrNkI2R7Pa9l4XqsZiLeZcJbFwy1xfhIWTMSgz3Hp5empNU3HqeuhQlnFiynJq5DkYh5CG+vbiFjBJyWE07rOpK3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWDoKMjaC1KhBwBV723U2LQC0Gd0CWE/iUHXaMM3tVE=;
 b=i6TgjIX5qnu3JlobpGTEdsHSqu27P/FknEeDOCZbFtDOp8oehiZ3T1/8aZWN65yszP1DfO8yxb1zfZ9pL2S1T22syKCZi8XTnKU24f2DKJ+rAoa02IOLPefFGj+MFMcAsn5nRpHeJ1zXeATH93mH2CTXr+crMvtdB9kB1YZgz40=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW4PR21MB1986.namprd21.prod.outlook.com (2603:10b6:303:7d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.2; Fri, 19 Mar
 2021 21:30:50 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::cbc:735e:a6a5:8b9c]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::cbc:735e:a6a5:8b9c%8]) with mapi id 15.20.3977.016; Fri, 19 Mar 2021
 21:30:50 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Sunil Muthuswamy <sunilmut@microsoft.com>,
        Matheus Castello <matheus@castello.eng.br>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, vkuznets <vkuznets@redhat.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4] x86/Hyper-V: Support for free page reporting
Thread-Topic: [PATCH v4] x86/Hyper-V: Support for free page reporting
Thread-Index: AdccMlTLMSKb9zjfQ5ekuWl72W2QRgAwfZZQAARAtUAAAFm5oA==
Date:   Fri, 19 Mar 2021 21:30:50 +0000
Message-ID: <MWHPR21MB15932DFEE4F0756419D58525D7689@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <SN4PR2101MB088069A91BC5DB6B16C8950BC0699@SN4PR2101MB0880.namprd21.prod.outlook.com>
 <MWHPR21MB1593BF61E959AC8F056CDFF5D7689@MWHPR21MB1593.namprd21.prod.outlook.com>
 <SN4PR2101MB088036B8892891C5408067BEC0689@SN4PR2101MB0880.namprd21.prod.outlook.com>
In-Reply-To: <SN4PR2101MB088036B8892891C5408067BEC0689@SN4PR2101MB0880.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-03-19T19:21:10Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=37bbcf07-6dff-414f-9af4-6f29abdf034d;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 55d69b49-9ecb-4140-69a1-08d8eb1e44c3
x-ms-traffictypediagnostic: MW4PR21MB1986:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW4PR21MB19861C89C701145A445F904FD7689@MW4PR21MB1986.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l7C8oN2CUg4/uYNAWVYxByWQ540w0ss2wUSFXABKO+Z/9BYxRbqHBDgtAijpBeiuaK10SGOA8xzAybCOLBp50/H4R43O5i35s2bKxGAFI142W6xEdWoeuF34cJ66uWZPthbPaWZ0T6IJc10+NMIAURchsBjXw89wOe5PMVaJ7Zt0m+LspS9fnHAL7CQA6VMtb3v/Y+9pZaV0K8UnaEQW/EFLbvE9LDHGLNOQCWheDjnibiIu/2jYyt79ECPKVSq0sCU0SW3Rf8LAQekEm5QGDJNrFuKq4BW9kbpqgxg3QtvO5xncOtQKrRj06EcSyiLc51leGgXR+h1O4rurV/EW7YWRwik1jUyTCasNy1L/U+P+IvWuIiWkOialGNhob6LNfZoiJdm50aLUiV8VB8fmw8cFKE2kxjfPnF+6hMAsC5VQqcx+Ll7ql57y5EaE0jPAMnCIBNJ+aB2vbCFtw/U/byOUB9a6LotUa6JdKerrql0txjnKGl/mArOXmVq2tUDHCTMOHuxPmC3CyCvh22C+EhtBlamIRCBON6ekrD6aWXvb38w9T0mhiN6yJEwb6uc7qW8tHVXJbIqHxi0CWaJVG+pWrJIe6bveNipXbo5r0/SjVr4Uc/naAtBN86B/QNxHlVZXDuj2aRMudcvbPxeIys22j3/WUrs3L7ThiT7O+tmUP9YfDzpkSPide4laJooP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(39860400002)(346002)(136003)(55016002)(66556008)(10290500003)(52536014)(33656002)(54906003)(66946007)(66476007)(26005)(8936002)(71200400001)(316002)(82950400001)(5660300002)(38100700001)(478600001)(82960400001)(64756008)(8990500004)(4326008)(2906002)(83380400001)(110136005)(66446008)(7696005)(6506007)(86362001)(76116006)(4744005)(186003)(9686003)(8676002)(4533004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?9VaCkThwvkGmO+uY0CEG20zV1piY8EpdO003WRq1B2TFZ4Sp0X3vlpZ5Dr2V?=
 =?us-ascii?Q?2OU1cWGD1deIjZbMVyRgdhDM3kLAOiTLT1EtWNfd0j32Gp86ahVwR4+rzhIr?=
 =?us-ascii?Q?h0ATMGisc3/7sDna/Tats2xrw95/WluteRlX/bYZDe7LlyNyWNROY8hwQiSN?=
 =?us-ascii?Q?fOCt1FfQYj2DiO6KBZMlWZulkFEvmhWTDZcjTcu95MswGmYgOQviCdRvpynw?=
 =?us-ascii?Q?6NNnKt2xz9LiGGiFVtlW/67TnztaTtMEeoSXPVld4GNmi4IVsMphZ44d0HLW?=
 =?us-ascii?Q?81tofR9LRfi4xMERTc1nT3ZLKrhDd7/6AQU6nvES7utJYN7Q5yaYs27kGOxQ?=
 =?us-ascii?Q?TRhu02vWSkRdViubFRLI/xY5LIXhx5EfEA66uibOlvnB05Yva88Pev5gIJet?=
 =?us-ascii?Q?KawbLljxs4YjdLl40sx8snspXDiJ7pF4i3RDwFaAIL6GKokpTo8flgqKgfBZ?=
 =?us-ascii?Q?4bYvxYZMz5bAwJ+0ls4c13ofsbrF4hxPK3Hh31v9fq7eHXklPwK5CkhNZ3Ct?=
 =?us-ascii?Q?YspQL+P6hyhA1NMFlHekOhA0H/qQ8uIeO/xHL03nODMcnZboqD8aOU9q3ORA?=
 =?us-ascii?Q?0FxEN5UfXVaOhtIaN3KENhxxM9L+UTonR0hZPdWP2v+UXVY47WxqExqgEprH?=
 =?us-ascii?Q?CRBzufHEeGWF3tpRyB7hlXc5LFW2MKsmuHZTzE81vruG1uvtDbF3pvSGZO5H?=
 =?us-ascii?Q?xwXf1ea5c+BlKMF/sk0YxXJUkaqxNlCTl24c34n6Zd/mnlyv/0fUG7Y9iIUq?=
 =?us-ascii?Q?rB8SyIQ276e7ZSRBW63dOjZ+QrlVRB99uyCxWo0yg+GbGmhg+ONI47VMjpaY?=
 =?us-ascii?Q?/qHcmQPXsgzGMcCDusQBCKeDK2bj43jSshMp0kSyacePviIgv/kI8tK3NYdb?=
 =?us-ascii?Q?/mrMQtSizZIb/RBJ9yBSBTQBsN/G+8F/osaKwrTDgWnG3n1kQVClH37D9qU3?=
 =?us-ascii?Q?ueBEFbrrLshAsKYgJv370PCBgXzG8y0Q8zOUt+TQNkFwgJtMSgtKodsyeZP8?=
 =?us-ascii?Q?xu7qEQ8oVS2ShD415wzOZ0F2mWrA5suLbo1wsCI60QnEy5g4WZrjQXnwiZEO?=
 =?us-ascii?Q?ULMjJuqWi8w1eNJmsCyfoqf2lcR3fI/X8Zg5/0u4Wj2oJPW2KXI4EyLoEjgz?=
 =?us-ascii?Q?/hH0Q+3bu859NDoZwZlxSSteP3rGXt5Pa6RKQ5XYpM17peE4VHPssQWYQM1p?=
 =?us-ascii?Q?KPEeCtmqa4IJDiqt6cMufXmQnSkj1CmVlv1EHyIki1BcSmAv2xn4E1IM+1XV?=
 =?us-ascii?Q?yYGLnOPLefgqKKMMB85ycIln6mAH2ZGqIP6UMYMFMwG4ShtPs7So8QObV4GQ?=
 =?us-ascii?Q?phMCmO8wm2RhdR4DugX66mvD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55d69b49-9ecb-4140-69a1-08d8eb1e44c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2021 21:30:50.6729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UrSGKHCxFX7q6Q8YsWwweINJbyOzAbN+1qGNx/z8NO9otbMn/w5mkn2HL0nSGUgKakDn3y93U42uRPwcvJ4d2M6AAPD2zJpbj6AH5fpAyTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1986
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Sunil Muthuswamy <sunilmut@microsoft.com>  Sent: Friday, March 19, 20=
21 2:21 PM
>=20
> > What's the strategy for this flag in the unlikely event that the hyperc=
all fails?
> > It doesn't seem right to have hv_query_ext_cap() fail, but leave the
> > static flag set to true.  Just move that line down to after the status =
check
> > has succeeded?
>=20
> That call should not fail in any normal circumstances. The current idea w=
as to
> avoid repeating the same call on persistent failure.=20

OK, I can see that as a valid strategy.  And the assumption is that a faile=
d
hypercall would leave hv_extended_cap unmodified and hence all zeros.

I'm OK with this approach if you want to keep it.  But perhaps add a short
comment about the intent so it doesn't look like a bug. :-)

Michael

> But, since we don't expect
> the query capability to be called in any kind of hot path, I am ok moving=
 this
> down.
>=20
> >
> > Other than the above about the flag when the hypercall fails,
> > everything else looks good.
> Thanks for the review.
