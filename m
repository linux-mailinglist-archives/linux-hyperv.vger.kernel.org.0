Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B88368DCA
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Apr 2021 09:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbhDWHTF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 23 Apr 2021 03:19:05 -0400
Received: from mail-eopbgr760115.outbound.protection.outlook.com ([40.107.76.115]:64834
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229456AbhDWHTA (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 23 Apr 2021 03:19:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IrdrKITcbeh7P5ax2fQ/XK0cKBYvZ21ZTKjdkvJ0QaIMNr6aVxGCDFQY9kJBy4OeLg18NmLDt2m7IcIuMwdnIsOCsYg0WBy9gRYr2qJ3+vzAYXmoqyl0Hk3A87zvaB3d4kpTR/XifC8vh6NIL1169Q88TvCBiD5aT+Cfkr8Vi7p8P5PNIUFvet7OpuGDET+4xXvFqgSsc9YSvIyxj3IAZB6ZYBeCZd/ZNMvUkWTD6c8W26gF8T/eHZ90Zu/UtIqVA3DVs46DepOqevWyVoprhVk6/9pcjqVvfQX9/3HeP+BOFZybtC7cRz7TN88G0vCJCHgQSIiWt41yAlT5b/bWpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/S26o7WRX8V2WKxxaIYXFaeJTPOQjMnCQTZRo3jaIg=;
 b=UBSI5IxQgdCStKycDl1oI/Wm16nM15ooRG+eHCwgyz9tQgm9f5KOVFlMhK+7gQ0VbJVaWWhakAhkR249+3PEq/nM14iXvzUFGbXxCRIz0MHnE/2j7SGY5AEMR7Ak6gvpmQ/96Nzi4DEVwWar/tW7bBmFy0XgGT+FsD8TzYK00ydqrvjmD1+u34x3JYIGo80h/eYQcRFG4Qa02UPcfZjMcbXx8Ud2Q44NQ11T7MwiIYYbCuZey5hJiVe1zKT56TcRTLEWO2/xKResuSq79pDUrQc6UGTl7WPYhzR0ZvT2YKpZJySxVt1llpfzRxGTAv5HYCFSsV6CZHhyO1DgraUlZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/S26o7WRX8V2WKxxaIYXFaeJTPOQjMnCQTZRo3jaIg=;
 b=XRcptkIIXenIbvYmNImgdkwHQcPacUOuI7CpENXAPbPl5BymHERdPV27lP0p3nRkfpn9Oef8U8ADeY6ySB4gllfRAYWoYMNy3NaNy3Snys7AQ47pEiv9julmtxh9tjjL4aRtAn719rP5ODDsKBOvAxnC7GzsxaMpQC+Ypzg2AcQ=
Received: from MW2PR2101MB0892.namprd21.prod.outlook.com
 (2603:10b6:302:10::24) by MW2PR2101MB1756.namprd21.prod.outlook.com
 (2603:10b6:302:d::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.3; Fri, 23 Apr
 2021 07:18:23 +0000
Received: from MW2PR2101MB0892.namprd21.prod.outlook.com
 ([fe80::5548:cbd8:43cd:aa3d]) by MW2PR2101MB0892.namprd21.prod.outlook.com
 ([fe80::5548:cbd8:43cd:aa3d%6]) with mapi id 15.20.4065.008; Fri, 23 Apr 2021
 07:18:22 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Long Li <longli@microsoft.com>
Subject: RE: [Patch v2 2/2] PCI: hv: Remove unused refcount and supporting
 functions for handling bus device removal
Thread-Topic: [Patch v2 2/2] PCI: hv: Remove unused refcount and supporting
 functions for handling bus device removal
Thread-Index: AQHXNzrM+cp7EtSjH0igMJe2zobO76rBsilw
Date:   Fri, 23 Apr 2021 07:18:22 +0000
Message-ID: <MW2PR2101MB0892BE19CBB08214B7FEA5E9BF459@MW2PR2101MB0892.namprd21.prod.outlook.com>
References: <1619070346-21557-1-git-send-email-longli@linuxonhyperv.com>
 <1619070346-21557-2-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1619070346-21557-2-git-send-email-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=770ed1e0-2138-4406-a319-8c807a78d1fc;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-04-23T07:14:33Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: linuxonhyperv.com; dkim=none (message not signed)
 header.d=none;linuxonhyperv.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [2601:600:8b00:6b90:753d:cc43:efdd:9f99]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf09cf70-415e-45f5-795d-08d90627fabe
x-ms-traffictypediagnostic: MW2PR2101MB1756:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB17569290F1B7C7B9A3EAD9C7BF459@MW2PR2101MB1756.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jFH8TCzk3YpRVHuo9gaBDM+FbgeT/rrG6KKf/QQ+uMtM39STazLgNriKj+4wrlazNVXaPKg6HB0Qrk81HOV19SzeoU11Fr3M18BdQzBHwK04AXmkNUYDPxAQuMyJa2HVOMmKPBbkQ2g+vEYJfO0sPZ3yoGS/Pn7qNNPtPMyAPaLUvGVZhvgBdI93HYNamhgqmE2XW309AYMjzpYeEbQT/Z2RTG0X/GhEBAdCMq6okDirg3xGOJKggrAGuswMdg27DuJ+xWwDDnRJ9DThltX99Vj6IG8A58NqDaNknW9HcCVhF7sdUBMN5X27frBTKDnHgYUOulzZ934Nozu9c7ZUcRaJyIvyznH0QsaaqPKEpuOVernQHNhV9urIgZlPUPQCLne6xGCLh35aq3VWYE4/0jNMzPsmnsfX3i9lrvJrf0LOGiBwC11aZqyIcQTtbDjo9bJQtPIluvUelAfsm5hTTaWDYKGEfwF27zgkU0zcEd6+meUMUU2+p6gqEIBs6J2dAP01/yuSKyhHFXhwJR/QzTOnO5U3OH+PVyEXsODGksAWn/Lw6zxYe3udgW7JYPYW+v2itADiMV8Cmr+5NiEiPUkvwHj5pBEDj9vHmqtLToK8anz1uvGoTvYKlAv35N+Kh7kPFSCuDOrLNyWnQRoVUw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB0892.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(107886003)(52536014)(71200400001)(33656002)(186003)(66446008)(478600001)(64756008)(66556008)(66946007)(10290500003)(921005)(66476007)(86362001)(122000001)(38100700002)(110136005)(76116006)(7696005)(82960400001)(55016002)(2906002)(9686003)(6506007)(8936002)(8676002)(316002)(4744005)(82950400001)(8990500004)(4326008)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?cSfhIjPG4VlueOVO+sVSGwAhoMGimHOT4m2RuuM2o4TCb84LiYplqn9RskL7?=
 =?us-ascii?Q?6TPsUCW/XkBxNa/xYf7KKKBm2ZB1ZN1of/aISN1Os7nepwdfwpkWoHVL2pcQ?=
 =?us-ascii?Q?4cwQxPaLqXBNR/NoQPPMXk4tHxZd6grg/jDQckJWsk/y1M6H0MW2xZp9Xa43?=
 =?us-ascii?Q?VX1Vgw+oyEUof8TYZeVWDjII3q05r/86eZXI6IQk4Gb5FYWyhRwU3HFDs8KO?=
 =?us-ascii?Q?hV32XBy2doFKzf1A5EXNa2WkGWQ9qsi2cyQKGBddCuxmh/qZQ7yplKTbjKYi?=
 =?us-ascii?Q?fwSAhY7nopNuKvq2GuUq0CMtDMqdm8rrUytDxunhKIFoyA+XK+ds/frYssx7?=
 =?us-ascii?Q?dOtAsx4fV0fdZOGNNGmScgPa4kusb59V/5X0/D8Hi64+18/tc1Ws33XiPoUQ?=
 =?us-ascii?Q?HAwVq3t3NVs24FxrCYQ3aNs2nXcyGKKiCcBuxk0KedwxfzQvnAnfOaQ8jdm8?=
 =?us-ascii?Q?J6fNHF4NS7acUyXASlXxfdmmLrQhqtwklUTaqMq8aFa6LrVFwawOmRNZIdGC?=
 =?us-ascii?Q?fTdJIbmtOwXzklUr3Y3VtuCJ1EzGKtRrzbWd1q/Dc7ymn10brsNDciRYDSS+?=
 =?us-ascii?Q?dsHcnX2Ay7jPP9GLswW0U5ruGqR5H4SfvlKsqMQicMvdJw7BADPHzUsoVb/H?=
 =?us-ascii?Q?XwkgW90HComufEp6jNS2fZZevygLVce2Hi5WINxGLDW2u6GAkMCxsEWHOfeh?=
 =?us-ascii?Q?QAejA+CFFlVu136PqjePauCCkRb7OANomit+wfDr5Zkw0v6Lrb66RWBSfJ0M?=
 =?us-ascii?Q?BwHdojumQ1yCbgHXrT0vQf0WU/+IAsFSLUREXvDg07cTYl62UknhGlLA2coh?=
 =?us-ascii?Q?zHRTubqb/DFd7sKq+EKAWjTf6gA44UWwQLm8P34riEcDNQ24/om20RoChZf3?=
 =?us-ascii?Q?JReuOI13zyKJcK9SsyVjsgR9ylqWIizf7d5qd7p5poFsDWLRw5Gij3yYfcDJ?=
 =?us-ascii?Q?Ona9kTqeAdFwPYZoG03zc2VwUZvZasNUxfq/6prqiaqsGUbCbrtVSlKjeF5F?=
 =?us-ascii?Q?C8v838tR1BlgeVrrFWiF+Ecg9qmr9WNu7MOVuMSJJakX9bG8OWOBQ4Nv6jw9?=
 =?us-ascii?Q?cU8SQd0NP1N3GNWknnERaRRTd5yeLhpICQPRQrbgZ2tBtq+qpIF0p8uUV9OV?=
 =?us-ascii?Q?ql3hNmLgcehb8T/WOICbjnRJbV9qCIOkWtHDReadOaQsuX/ZXNOHvtJjwJf3?=
 =?us-ascii?Q?HIqbhXwTXbFAbsqMQToxocHC+hlJ+C4ZWlprB9N6+813Ev5q7U88VZ5wtQrG?=
 =?us-ascii?Q?5SF+69L4P4eDr2t4xt3cAoQz5XK/IB4ivDeKz/f+2DEnf1refKs3Yimn3G4h?=
 =?us-ascii?Q?8fwUH+e19AFx4StO2wfOCiMv/6JRhfGyP0prtJDJtuCSJ7Yls/8mHbYtrZ3p?=
 =?us-ascii?Q?QwXBM0W5J/TZ1BBpwMv8blb5fbOo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB0892.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf09cf70-415e-45f5-795d-08d90627fabe
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2021 07:18:22.7655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MJ7I6svWYncK+UT+RQdMSVWsQ3E3E9fxf4iPyStaXVWBgr8cnjrGTgq4+fYnptml44aQNcmcpq6xDMH1wyy2Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1756
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: longli@linuxonhyperv.com <longli@linuxonhyperv.com>
> Sent: Wednesday, April 21, 2021 10:46 PM
>=20
> With the new method of flushing/stopping the workqueue before doing bus
> removal, the old mechanisum of using refcount and wait for completion

mechanisum -> mechanism

> is no longer needed. Remove those dead code.
>=20
> Signed-off-by: Long Li <longli@microsoft.com>
> ---

The patch looks good to me. BTW, can we also remove get_pcichild() and
put_pcichild() in an extra patch? I suspect we don't really need those eith=
er.
