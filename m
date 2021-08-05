Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A38A3E1B3E
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Aug 2021 20:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241197AbhHES2Q (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Aug 2021 14:28:16 -0400
Received: from mail-co1nam11on2132.outbound.protection.outlook.com ([40.107.220.132]:63808
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230317AbhHES2Q (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Aug 2021 14:28:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jwq5x4MZBO8dU/p9xKcI5YVEd4lJX/T/JU3FacGZVuIiZW9RHBbLBJFF2pPcpgpnwujDpn7JwM7YVcjbzjaEtF94r0WrRMbK29FAhgb1ZgkRDppRJkGeEij3YgbXce2qhxNLxgxMLBF0peiELGgSQ++T1zwIfnoCoH9oJngGWo076Vayp/MrLw1ikZcQ8kUu2XB+0ZzPVMtbfT5JuxNcg8qskYlC7lVRjLq0ldS25xmXBQaUTCeleX57FHF5nq4JneGpyDH3N4WCpTGuVYziNc7WS3vY7ozoaql67/JTrorBuD8YPfQKjDrGrUc0YG2dN1UW24B4+r+Q9eHEsrODkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQp8UmEs8hXC6sXYnFMA6l400PzFcimz10koZspTxN4=;
 b=E+/1gYOOxUMAq1ph7MfWI2QuDu5Xm/2k8u1wxofKgtw1XImE/kcSf3aa1/iXO/goFkNsQ/PAhXriF4C3M3RMSP4Hm0SuOf2ObQ4cDFm4Yke+KEaKVoSzwQawhKkk+rnfO9pgh56lT5EUDIQcG9KvNEEmpuhXTMQOi33xkquhj7rEeMb62eEQjPi0iG/2V87oAYPqYOiLMV+pXs9XLnWSaKy/Oc53tay9KEMzzjJ/iaJMaptAaFxqjCWoseDIJVH1fJE1UW9dz5AOnJoaeyYFJgIEpuGn016KlTQBpuE2GGAXOakoILRRMEWQKgm7T9K3A7GxxE63mpJhpD32iFtLcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQp8UmEs8hXC6sXYnFMA6l400PzFcimz10koZspTxN4=;
 b=Q2xyFkMeBssPVPzh5+vWTfBZkkaJ2WIlLd55GcA8yl9RzKolZhdWLbOc2e4wLc2eku2ch516fHjCUIrDNX+tha2l51703O8r86vJqKrt1LfWdqkXMBBv1gYALKoHkua+1hZQ5AjXQlnxYhQyw48CR/tPSjTeygrDKEG1L0jiocE=
Received: from BY5PR21MB1506.namprd21.prod.outlook.com (2603:10b6:a03:23d::12)
 by BYAPR21MB1671.namprd21.prod.outlook.com (2603:10b6:a02:c2::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.2; Thu, 5 Aug
 2021 18:28:00 +0000
Received: from BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::75cf:f11d:d80d:dfd4]) by BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::75cf:f11d:d80d:dfd4%2]) with mapi id 15.20.4415.005; Thu, 5 Aug 2021
 18:28:00 +0000
From:   Long Li <longli@microsoft.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andra Paraschiv <andraprs@amazon.com>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Hannes Reinecke <hare@suse.de>
Subject: RE: [Patch v5 0/3] Introduce a driver to support host accelerated
 access to Microsoft Azure Blob for Azure VM
Thread-Topic: [Patch v5 0/3] Introduce a driver to support host accelerated
 access to Microsoft Azure Blob for Azure VM
Thread-Index: AQHXiceSNIn8c8rqq0aMs/Uc2xnVEKtkfdiAgAC9ANA=
Date:   Thu, 5 Aug 2021 18:27:59 +0000
Message-ID: <BY5PR21MB1506213A9BBC8285C01D1EB3CEF29@BY5PR21MB1506.namprd21.prod.outlook.com>
References: <1628146812-29798-1-git-send-email-longli@linuxonhyperv.com>
 <YQuOca6cmsY/CIiW@kroah.com>
In-Reply-To: <YQuOca6cmsY/CIiW@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=106eecaf-44cd-4b43-9ef4-1426441b852c;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-08-05T18:25:00Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 922e56ad-20f1-4df1-4b2a-08d9583ec118
x-ms-traffictypediagnostic: BYAPR21MB1671:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <BYAPR21MB16717BFC39E3BCC299E2BC00CEF29@BYAPR21MB1671.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oYTycUFW/TFAY4IYGMuxDyf4g1gVSHKvgkD7WyxP9plYpIpGMUx2l3V1rb+xTvr/q9Xf0nIeAokpevm/00GOcAtZ6BxEMaOVlk4x54eB5BCwltzXfAUYDHTgpVTjDz6VNspI9NjJT7aSnj4d3wK4YeD9LY1WZ6biE+upXW8+dLJbK5slRAg+RvYSiwHU1qcViVL4VGcm9wVqcWhVz03z3iGp46zkA0nUf3X2YhOjA5yCfhBfDMg2Vv36x8gy1OtehfVIjK8e9SxqhoouYriaAVNmGZa4K9TtXfYCgq7YLNymxFiw+zFDnAU7/LssKbuPH/KZcYCLCvPYBTszwLOEjWEyVlIQHm4not7vpzp4XHu4lbo12iL/9VjVSnEmX2Zso07o76CpVK3IHizz4sjAqpPYyU8MS6wswkHLNrOQ/LkKnCKSOA978LzhgBH5z245N7fLXAwsxhIPsq0FZmrfObRn8dKo2MPQs/tOU9/L76Vs7w4XvWkelE/13vNJCeaqOZM5JINcq9/4bHDJQZi015CQCcSmv5AVyc5GZiuZE6DbnkpoM76cGT3p6L3iPjenTtIL3MIKX6GMWvXGlC5FlNDDOA4MUK8RMTz9xRWDlS8QNrIR8AWwLEuscXGs1Y36ak7y+dpme4V+WuZWodjukipRUXFQ0dUaL55vjkqaCimGOuO1K1xD1XuIQ0nCPaGmsk83NEEB21MZSdZRc+9unw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1506.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(47530400004)(66946007)(86362001)(76116006)(26005)(66556008)(64756008)(186003)(66476007)(71200400001)(4744005)(54906003)(66446008)(8676002)(8936002)(55016002)(52536014)(110136005)(122000001)(5660300002)(38070700005)(33656002)(83380400001)(7696005)(316002)(8990500004)(508600001)(2906002)(7416002)(9686003)(10290500003)(38100700002)(4326008)(6506007)(82960400001)(82950400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bg0oZkFXcftR6m3sDA85RdpguuQFSulwQSQIuORLOCI5uX41xhj13UBKDyn/?=
 =?us-ascii?Q?1ZHqXTB4pjW4K8aECBPRVX/6kuiOZ8liZlRMcall/YYaHFEXGiWdlODZ2Zc8?=
 =?us-ascii?Q?3LPWh9UBQuLzLzvEND/qSi3stRLdvy3BHsu1+x+JKEAmjgFtDkECLlVqTYT9?=
 =?us-ascii?Q?JxvOVSvy38+6rAumVQqIJw7MRxDXBQQiYu4iAJEDmjr1loOBMt5mJx60tz/y?=
 =?us-ascii?Q?FMV1qt+aA4UUeVhnKOx8bzwNLFgjfRf+cv1fcBw62rFxIDUaFDauqXDQyIWW?=
 =?us-ascii?Q?iH9YRqbq3QA6z3Xt+WxvpOLkwgcLpRPKE4MZFW/1CcribTajeoc0QE2ZXD4X?=
 =?us-ascii?Q?SCrIsARW7Q8A6uN3WNTdhllGrvVa9RaXhsAEer0M+BGGb7pAKGEPsm8YLtKI?=
 =?us-ascii?Q?8WyHrmepyKCWLcPJdrZAe0zw8091TgYlBkflya454dIpLT0LqtQmUONY90NC?=
 =?us-ascii?Q?TaSq/iRcdMbe9KhoAHX8SNRx1Qo4TXm8TsCFcRtesC8PngQfW6OcCFIhfIWq?=
 =?us-ascii?Q?7ouTLo8+wnPy9gknFc5lWkmM3b76gYYk3QKHxuBFobUPmMA0a0uZ0zi94gOU?=
 =?us-ascii?Q?hNdwoZ7FZOs6USjYfY+Vb+zfn435M342KkHa9js7Y2Kqm/UePvnzHs5KmO0y?=
 =?us-ascii?Q?peOGrluntaDOmSvFtMVVJKlVXY6O7T2GeLGMoQhXCAfZ+4MuYHCgBQJH9Bv+?=
 =?us-ascii?Q?kAt+fdWvzY6oZV+zPXboeZl/Qgxakol0SP6o+raNsB8oXW+EqxTxvtdf+sY7?=
 =?us-ascii?Q?L7rTeLkE9YtG7b1jfTDBH2tvU+AbGMSc678w7Ttkenqedem4lEUScBdMTZ+i?=
 =?us-ascii?Q?DIX4K2T6hDQuZVEyGkGmuECLpdJoKb/WL6B4mWLyehADxnOk7j+O03kLFOLr?=
 =?us-ascii?Q?my0feJFUf3Afrb1nuzCY3OgZIq1bou2hHXubUFeiGZjeLJmblL+y1qeciQLr?=
 =?us-ascii?Q?8GAfeIjmACy8B+o706UtSfOC3xzgRyua/vdOgGwPP7fUqlQnuH4kyMzXa0NG?=
 =?us-ascii?Q?UJFn4DUEdxS1FxU1bzSTUhMUPw79vc4G1khL1pRQF2NfnOr+6/3UzVtG+JOV?=
 =?us-ascii?Q?lrCgfXt8p8Zq9Jc/La+/D4QveaACClml06v7uASYiyS7vzFthWbzqqpdfPdM?=
 =?us-ascii?Q?cwDHWIhy+R5qDxIgOIHQqEDL/X/aXrqcb9TylZjp3Ubm5CJ21sbxo6RafLWx?=
 =?us-ascii?Q?Lldn9B4eX7OXKx4yKuLuopmBYET6lPLMzJDFT5rEQqeb40jE1N/BycfgTJyr?=
 =?us-ascii?Q?VZNDdtQIbrB4XL5ZxQ3xIJ6spqGtoPYjupqTpEOHT0CBhCXaFgjOUpPpEnTk?=
 =?us-ascii?Q?iC8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1506.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 922e56ad-20f1-4df1-4b2a-08d9583ec118
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2021 18:27:59.8426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gqLvBGCSMCp0lwqNubtjOpdl0H8W0F0P2WVLmeR6i05/PoRh8SbgKcIjEC3RwmHjThyVGpinSmAXqLtft4tbCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1671
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: Re: [Patch v5 0/3] Introduce a driver to support host accelerate=
d
> access to Microsoft Azure Blob for Azure VM
>=20
> On Thu, Aug 05, 2021 at 12:00:09AM -0700, longli@linuxonhyperv.com wrote:
> > v5:
> > Added problem statement and test numbers to patch 0
>=20
> patch 0 does not show up in the changelog, please put that in the patch t=
hat
> adds the driver, otherwise we will never see that information in the futu=
re.
>=20
> thanks,
>=20
> greg k-h

I will fix this.  Do you want me to send the v6, or re-spin v5?

Long
