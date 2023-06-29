Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574F0743052
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jun 2023 00:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjF2WTB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 29 Jun 2023 18:19:01 -0400
Received: from mail-dm6nam12on2093.outbound.protection.outlook.com ([40.107.243.93]:54400
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229742AbjF2WTA (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 29 Jun 2023 18:19:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M4t8W6RxZaXMigf7Yymv3hitPccwmuov+U5MzK6e75Morc6ZC/m8K8psqp0HB+YCX6llD5V86O6mAVREPyS9tubDVx19fDdrrrP899l0UbOjO7vg0V/rizWo1Mp+pjQBlmhkMv3DJ5el4XjsEO0MFDqeL3bpCYqjmZu8tCsrh2t+ul590SILq7J5fL21TLTjRf8Ke/dO+vY1gqBadfof4MiKNkK80c3wOD9e82bUvfwh8hCtajNcp0RF24b6edB7GDmYKnlN3VpwY6t0kUwwpnz0NzHvtc56iDySUOcz9dkcLLWL6vroGBXjDRN1T6zgN0rcLJOQTnrZ6aaLkGizWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7b5eK+1FlT8N4cDtSMAcch85nDINSCqGoTTYvnUGVo=;
 b=dJaklesJY3tJ3dhS6vrii2K7DlJBRZZlBVeAYHzY0ugep0KFqdvHCopvvjnAngNpE+YGUFo/+NvPOD45jLg5updSQgoiyMBsCJIGcXvxBH9Sk4zZVGorh5biCk6VccRLZsdf4p4lzNGp9u5EJPxuG8JnfHWQisOeBitnKDcp8MOlMuPTpV2yorlUsBWPHG0JLKP+Wxz6IcUsXHW2vIpDMUxxu2wN+oU5tWxwLlrJAlJZf1a6Z+BimKUQO7UsO34QbZUmhboz/DGU0QsRgZ1Gqr+c8MbjKYlbmZHKUk/NZkIprE55+OkpS905/3CtchBY8NY8JHV59xNfHTjQr7vWUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7b5eK+1FlT8N4cDtSMAcch85nDINSCqGoTTYvnUGVo=;
 b=F7QbCVFOgyXv4KqyUW8Y5y9rRoKj4mx5GFVNZOFTfKcz7+7ai5YRHsnGx6e2ckDtgaAQHjEY0qlf7eqmijUgSCkjCMMWhjDTpRhFmfI37tNjp4zieDiIGMHsIBMt2LNEAgO657CbXUjmKJfgHEuBIya9Sx0QijYft+DzqZQ2DVg=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by IA1PR21MB3472.namprd21.prod.outlook.com (2603:10b6:208:3e3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.4; Thu, 29 Jun
 2023 22:18:56 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::7d5d:3139:cf68:64b]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::7d5d:3139:cf68:64b%3]) with mapi id 15.20.6565.005; Thu, 29 Jun 2023
 22:18:56 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Sasha Levin <sashal@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH AUTOSEL 6.3 07/17] arm64/hyperv: Use
 CPUHP_AP_HYPERV_ONLINE state to fix CPU online sequencing
Thread-Topic: [PATCH AUTOSEL 6.3 07/17] arm64/hyperv: Use
 CPUHP_AP_HYPERV_ONLINE state to fix CPU online sequencing
Thread-Index: AQHZqrwVgYW4CVLgJEC2yQxsCXSETK+iWaqQ
Date:   Thu, 29 Jun 2023 22:18:56 +0000
Message-ID: <BYAPR21MB16886629B821C5D846125004D725A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230629190049.907558-1-sashal@kernel.org>
 <20230629190049.907558-7-sashal@kernel.org>
In-Reply-To: <20230629190049.907558-7-sashal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d7c21818-d6b3-4a59-9aa3-04c16dc7696b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-06-29T22:18:01Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|IA1PR21MB3472:EE_
x-ms-office365-filtering-correlation-id: 8df8411f-50fc-4ff7-8a15-08db78eed47d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w9sGlOtE0YN+42BC2YuBphICJWjNc2cM/OJOcOk5RaB3OorCoZZVok18JOxqoDzoUWzxdUmJff+8rYR9KzCm0egwzMD2GLm6dl0o7HIXQS45ft0bfCBEhwXIrLc0U/Pbc77XjYYk7oOJo1p0Iba6tbkmxK4TgwF7sdPUiSQdI1s74pc5Vw45+RmJdLR5EEJL0kxdxcbmGLgmUvE5kysPlJlu8AC9xnO+QE5lqSk3vNYYBbvpQHKzySAInFMMhynRkaE25UAOh9o0DHUCw+1QqW0IywCO38+7JhXfOfVogn/+Xk52nkRNLqnYsRtFBp0kVwBz3YKkyYnRM6n0pBFVGTj93BAv3yXhnNXprvHaBDlVhC4eZSRzOoNcX5z8fAB2TRSKPU0TyEzkfSN2UwlklJ7lsG9K7r3nFoCohvUtA6yCoeqE5mCI5KzDbZdh/62AhZlB2D+EjyJyS416ycS9AnvkOjHN7ugz0mPuJlIJlucY/7IKCFn5CoIt7OgfHbcL7e+piWH6JQ8vzHRurahOgK/lrBHh2M+97S/SBYUtHz9PuL1TqTWvkJmq1jvdJI8jSbaSAElAPFp68Y+inOSufvRbu2ax9iz8m3i+GAKRl2cf7zJqY4yphkaYYuevug5ZZSsIHpHzdmbKETbi0NDKrOkwAkCCylw46zWYwyIuKqU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(136003)(396003)(346002)(451199021)(9686003)(186003)(26005)(6506007)(41300700001)(7696005)(83380400001)(478600001)(10290500003)(110136005)(82960400001)(82950400001)(54906003)(71200400001)(122000001)(38100700002)(64756008)(66556008)(55016003)(66476007)(66446008)(76116006)(66946007)(4326008)(316002)(5660300002)(52536014)(86362001)(33656002)(4744005)(38070700005)(2906002)(8676002)(8936002)(8990500004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eT/sx2DqS3dEaPCUunfupkwq7for0s6ILx5f7P4+obdbB2eTMJfE4EvrjqHU?=
 =?us-ascii?Q?ErfhCIslGLt+1IxpSbRJTFq7gbCblHz/ZmRKxlFh9LrN7Bv8synJ/pOo1KNX?=
 =?us-ascii?Q?hfmr6C77UyLPr/OBchdjLFcs5tkXl40+ToGTlyv6xv66gMKLuxzG2KB0/0Fu?=
 =?us-ascii?Q?/dRU0COP6ei2azjOBKt99/AjihzHTTo/xEc5CyV4wjq9PegiALxMfJ0rfTPH?=
 =?us-ascii?Q?1/aQiVyzadGebXsQ3BdX5nRr5WpNHPVAjvGxiloAIVExudmGzHacqI40ldiV?=
 =?us-ascii?Q?+ZqgHH8lQGajNvYALoo1sTe7rd0MnBjDQs/9o9Dx44M9MZkEZdTD+DVOfnNX?=
 =?us-ascii?Q?LxxhoTOrbdcRncx99TEwA+aHKQt6KYF7gYqHiuPi06HpbnVLeR1ESqYovRnH?=
 =?us-ascii?Q?VEkzykayzhJzfZtGF2O2gs84aA414ATIDuqA9KLam5DCqj4UQprP2V1vcsb4?=
 =?us-ascii?Q?X0YIqBS8U+g2NXCUkqPic/RkJ4Ntk+4OeguvRrLurS351mr12+iJBBf+eAlF?=
 =?us-ascii?Q?JVLIDNdqNP9iiFBzdXeUHffc3wpt3szTzthmyfHXYuTZ9kscTFBdBcjG4zW3?=
 =?us-ascii?Q?8tL/H7/UsYgS9zvOPNGNOCu5TqODYfpERXykQ67Dheg63kyrkZlAGvAVfkPf?=
 =?us-ascii?Q?QjkjOcFJ4BAmWcrMjdY8KFzi4PMHrktAeIm7N1ll8ZtYr3IHYeT+RZbD6/QL?=
 =?us-ascii?Q?auI2cwlkX1mJ/C36X63E99dA7Ni0uoYut3FZN0hGu2Nze4cgE/scACKQO+re?=
 =?us-ascii?Q?az8MjlKWqjFJiq3aVmJVT/0xsEyMvvDOzsVDbRDLVn6kR3wJm6bhCvqa5/5q?=
 =?us-ascii?Q?MuR8uMj71M8/2tG0IU6Q0Mw7MkiCQpHoeluhYm1oi9uRrEVuOgJ2ICym22zD?=
 =?us-ascii?Q?/Fx6LcsvSCwqKcHeukpYOsRmETkGkqpmYI71rL2weDGxteWcR39HtdPHxDq8?=
 =?us-ascii?Q?FtltkSzhfv4bcU6Q5E/lyoR1OKQ5PoOKyiG9JlCYZSMvXErMpDjLxF/ngTPd?=
 =?us-ascii?Q?bZm9sBKsPwDL8jmY4mHzcuQp6Ie4RcFK5DAwJy97iha7/KOK5LRrrbWg3mAu?=
 =?us-ascii?Q?vzdXy7VOwPyTmF6F/sqmEPNjlCuCKsgFEzMHw8y2TDqcS/aNMA8BTCMGTQhk?=
 =?us-ascii?Q?aA8cnL9QT6LGJjTjw7FHrkUuTjATmXndXE6Hm3WwERpVmnfI08t7ckWd16Jo?=
 =?us-ascii?Q?QbbretA7HnQ6rt7vw4FrNo/dI6L9YNm3bGbS25TlRRsGw3GWJxCpfJcmuWg2?=
 =?us-ascii?Q?gou4Jtx/MmHPM4k4ASnkk8J2vRxek7I1fB407eSC9N4g7knQiNlksPDWycDq?=
 =?us-ascii?Q?BIkxM+gNbBf6Zj6sPq1P2PkZNDfM53GVwYOHGJmBuG19wLO5YN/h7sw/2DBI?=
 =?us-ascii?Q?vRasdEFsdfBtEY1Tt17Qk9a6ASB4HCOdax5uki7lFotrANo5KG+QnR3+tybB?=
 =?us-ascii?Q?8fxj6ZZniTRc/eGVhY4K68S5YnMSH9G+POnBBXGl3j4Ng7oBKBww3O0URDnQ?=
 =?us-ascii?Q?zeoIveNen+3EDZD3lSMZSqO43ghE80R+PpBhCO83hkgDZAcapWCOYY7HTkEW?=
 =?us-ascii?Q?GIiO4C5MvbQukdYO9y5z5fmfxJLb5/ouaB0QbYc3+u70iUVdyANgzqm11mY0?=
 =?us-ascii?Q?ug=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8df8411f-50fc-4ff7-8a15-08db78eed47d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2023 22:18:56.5392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q25LxnvwRrB1fMPgTbuSLVW+vAEmRIrDwQCLL0+ZO7MQQZW5ats1s3wFsYsAMVjtZ44DIUHnzqUULxfS7iPZA1z1hsteYgnn6QebRQBArV4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR21MB3472
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Sasha Levin <sashal@kernel.org> Sent: Thursday, June 29, 2023 12:01 P=
M
>=20
> From: Michael Kelley <mikelley@microsoft.com>
>=20
> [ Upstream commit 52ae076c3a9b366b6fa9f7c7e67aed8b28716ed9 ]
>=20
> State CPUHP_AP_HYPERV_ONLINE has been introduced to correctly sequence th=
e
> initialization of hyperv_pcpu_input_arg. Use this new state for Hyper-V
> initialization so that hyperv_pcpu_input_arg is allocated early enough.
>=20

State CPUHP_AP_HYPERV_ONLINE was introduced in 6.4.  There's no need
to backport this patch to stable releases.

Michael
