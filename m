Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13AFA391FE1
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 May 2021 21:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235109AbhEZTC4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 26 May 2021 15:02:56 -0400
Received: from mail-dm6nam10on2123.outbound.protection.outlook.com ([40.107.93.123]:44257
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234849AbhEZTCx (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 May 2021 15:02:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+7ze7uBdg7XjxUHVtzOOqKPcW/xBXWxFIQaQv2+cWXKWrZ5I8fZm6Foh62z+eMEpT15lPKOq7HhXAZJ/Zspj2hifk3i4yYkg+nqjrz5NRewxYGyvO5kqvqzwKP1rPF/m16zghq5B4iKcgMSaGyaAC2J1fOWdVCRfIIhYgSNpmnBPHDW1OTia2KIfrqA48TBatGRz+9dCN9+l7itq14UXn41wGLY3QniLEOTR32Gd3Vuf1RBZ2UwpbMjKG0n7+94WqMB4mbTFwQPWe8pHYVI5aZvEiTSwksH68XGsjd4ZjcymdWqE8QN0h5FODwjj57dOlnMn6Piho14WCcPgxRrUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lep44mOXe1GTwuf48a4esxjcijB6YYkyOmZGFXsjOTk=;
 b=dvHGrO8an9qeOBOEJnM8M+dBX4NLFgb4ep/e5QK8J8+6wi6+sVaNXlS//Z05lUAGPpY06Uu9ZbgVfzosiBoZa9gL+rqJPh6pyf6GH+326f4bO7JjpN+mA1VuQj7MbnOe1DOzcvUIRw5gndvyV8mPiqRENS1ZwyffeuiyqPZ10oR+sqhlnc9xac8PUtCC6EeNmDDILlOW5q1E9zL759XbAGYxqOhnKuVaxzTiqcWcl3ThnEHmBBgLYUTRrgbvsGD/YOnYlrPEduP12TD5KQD45NoSWSTfmpDNq8Vu7K+JAEmE8f8NTUrgyp7yyJZ8CLIa3eA6M89gz7NXuMC7kFkNHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lep44mOXe1GTwuf48a4esxjcijB6YYkyOmZGFXsjOTk=;
 b=hZhpEYnZ3TLZGC5dbIdAB64oZ0edE05da+FCSKOU0iQEwM04UA661TNTGrU6Eb2vqdgLZgRcSfJF5xpoPSaTpHJWkptSNjjRR7pSqRKwLbyeBZ0J3ZqqWUPXmXaIoFwTtkKmxoZXV0TXXRsFntHZIlB61xgco10KUkth4HWl01M=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW4PR21MB1955.namprd21.prod.outlook.com (2603:10b6:303:71::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.3; Wed, 26 May
 2021 19:01:20 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::8dc3:55b4:b9b3:11a8]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::8dc3:55b4:b9b3:11a8%4]) with mapi id 15.20.4173.023; Wed, 26 May 2021
 19:01:19 +0000
From:   Michael Kelley <mikelley@microsoft.com>
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
Subject: RE: [Patch v3 2/2] PCI: hv: Remove unused refcount and supporting
 functions for handling bus device removal
Thread-Topic: [Patch v3 2/2] PCI: hv: Remove unused refcount and supporting
 functions for handling bus device removal
Thread-Index: AQHXRwXJJpcL9/nYqEOWFCAdcvdXMKr2NLew
Date:   Wed, 26 May 2021 19:01:19 +0000
Message-ID: <MWHPR21MB15931EE1B1D849537CA30443D7249@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1620806809-31055-1-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1620806809-31055-1-git-send-email-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b03aa2b8-45c6-492d-8a92-480b6cfb9bbf;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-05-26T19:00:23Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: linuxonhyperv.com; dkim=none (message not signed)
 header.d=none;linuxonhyperv.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3469170-6747-4fcf-2420-08d92078a5d3
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR21MB1955CC2F079DDD57579C0787D7249@MW4PR21MB1955.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1201;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K0xdIEGTrEoU0PaPrTz55v7o4RvouKSfB/nKMBcg7hfMRC3qsSqMlAFWa9Bw3bzmIA8U95/XFmS6Q5woZKd2x6FIzRzBUBX54p6+ytYS07JtwQP9Myf8/z0w7jRFdqWVP8HjGjR0Mm44e11xoulJ6BXhT4CZmlFjVSDpwFz57H51Uz3qZdExkh7lRnnnJHYwZLdyUhprem/oIWHJNtLs5b9teULDBrKzayaY5SOK1l6NWRwnJWeWobeGcDhQRXd0lspvLiW0cV5A9i+vryN1M/IJEXGAXBNwtDsFS6Dt6NMqNWTKb/Rrc4NlDUhqtAIN08edXu3ugKpdtCzGiUh33CmaxOUGNXAWSpFADYqhAZM4Yq6yHHszTM/Jo8ufHcZBpPIh+3443EjBIS3BtP6jLiQU7WZWe59+o8WHmkzMNnKKKKGfnD4FZKmVC4x+9CfzKIXZ9A9sLP5qYsI3egf6Us/guPLQy9YY1Bp58g5p2Gwu0DVstZfPJUXcGloOAmPvG2YPUyXqZxu7z9wxI//YSIpqivSDC+gU2Kqac+lZvQyuh0G0hFiiyvySLj/Hql3HbVU9dSKKbn4dHHY9CEcYbXsN2LDFAMuPo/oJdmd1uXo8PDRydhajzh+bBpELYEPfcEHPiuBxoVGi08jfT9qH7Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(9686003)(316002)(71200400001)(110136005)(38100700002)(7696005)(478600001)(6506007)(10290500003)(26005)(921005)(186003)(8676002)(122000001)(52536014)(66446008)(66556008)(64756008)(2906002)(66476007)(4326008)(83380400001)(82950400001)(82960400001)(8990500004)(76116006)(55016002)(4744005)(86362001)(33656002)(66946007)(5660300002)(107886003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?14xeUy4BVOgxgvbjMBASJlNhCEcLYHqZyqkOrgYbW9MN3jNkpeY+COdk/ZO2?=
 =?us-ascii?Q?JJ80GUeqG36vJIKtPmd+RxxgcGgH6/ejXlDoLrZRSbS3AEB5ZADgOlwGL74g?=
 =?us-ascii?Q?Pi3MXpz7V1fvXJOWfaeGIGNSQ8qdmpzXoSJwbQxilSrBZ4l05tUBM1YsXSgG?=
 =?us-ascii?Q?jGhaAcyVuYuoUxKd+1GFY7F5+WOMS6duW0VfqSJyxJ5WNW6csj2RQls3Ev+6?=
 =?us-ascii?Q?l3W9jAZ+sBfZdXDf427/D1AAmqQaPLFrrI/iP2eUI1Zfk+RBA8XWqiV5sjrI?=
 =?us-ascii?Q?krAJyQF8quj3xGjpw0Fq3tIlhgVvQFuHBLuj/yLXOs9qB6R4zQxi96TTZDSC?=
 =?us-ascii?Q?gf63IFhksblN+aSpsq5Z+Th8J9bzMrbJ3wSTqtVYzA3TGxqqfMacBgQqLJJu?=
 =?us-ascii?Q?eA+/ocKV05BeVKmBRfr9UUXgGNsoHKXO9TLQT812vKQTAlmG5Vnhwsd2myCZ?=
 =?us-ascii?Q?VpJW4a4/x+1oS0f9JQ1n0fxA3syIsp+k5oEhFqg/pHMKx+A2v2G021FgZAQa?=
 =?us-ascii?Q?OfDl/iQU81DdbyC7WTW3f30Cbjl4/gHeP5rlcEUsbkvvwH30OnLOlQKW7Otj?=
 =?us-ascii?Q?Ixl3WHHL6z6OVhtbq4e5J/nx2jhWFZzExYyhD/32lrX7kdkW65tiQncPr3Iv?=
 =?us-ascii?Q?al5c4gtwg76PNJm0RVgrtzWJrJ4T4bCBcK/HlpeDd0rVlibagmLrx4GgOOx2?=
 =?us-ascii?Q?PDYqkYElntiC93FRnbQxHfqQ0WGxnEoCdeDUqLNKUcu4tuUzQ5A9VZO0ZK4M?=
 =?us-ascii?Q?myjRkVRTYzgzKVnMnIkR3Yi6eJ9wgP4gsdkzutKXI1VBu/h4duSBlEVdG9UR?=
 =?us-ascii?Q?47KXQD7/9jFXSbV44edUu4cVz5NGkcHWk50bETMM7Arae1gUQk4kpWJ2AOro?=
 =?us-ascii?Q?reDvMgpAWl6AlHS6eQmeVhP0VVgPP7s5C4w3anRg4Y1yIPShXjoxg0uQU33m?=
 =?us-ascii?Q?fMA38gtymYxxkUupdhyRC6h97pRITTFd0iIkRTZL?=
x-ms-exchange-antispam-messagedata-1: gzPGmkSpXgVSTlqj7QuEOCQZwU0TOdhYTJKwlAwR2Ztp/UD0Li97uDtcYtQI2ttRpQA/iPfxELib3iQtscSHjqBg6gTqCeHdAzTKUdGmb9snLnCJu/vu3qD8sLwxa4HOhaHTCurHsnCsN0xqqBNVED2gzFaTVHqfULBcZlsYC5HBaewijVr1XfvS2PC3izZPI/GleBJNrkx41UaGl2Qnvxhp0cgmGPlrRdtNMZV9i/8Ii2Z7TlPofddg0lYaEGZW0nfPs59f4SV4e7rDxVl8plRj8pejBIqmd0DO0UdkM6yQGnSFsnZGHxJ0/M3Q1khY+4/mjkJXwtt6xL5ZFx4qoWEP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3469170-6747-4fcf-2420-08d92078a5d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2021 19:01:19.8309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WvmnRblcRPOJkN7rt6iNDnQaMcLa0nabfiC+r7RFQK1w1k3rEhT/hZ62NyaygqfXVKiq2NEpu3JuFrtbe/6kG+jhtTxMWqiyDu2hG+hsxj4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1955
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: longli@linuxonhyperv.com <longli@linuxonhyperv.com> Sent: Wednesday, =
May 12, 2021 1:07 AM
>=20
> With the new method of flushing/stopping the workqueue before doing bus
> removal, the old mechanism of using refcount and wait for completion
> is no longer needed. Remove those dead code.
>=20
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 34 +++--------------------------
>  1 file changed, 3 insertions(+), 31 deletions(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
