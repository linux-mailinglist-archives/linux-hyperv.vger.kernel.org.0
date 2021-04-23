Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 910A2369A61
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Apr 2021 20:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbhDWSuG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 23 Apr 2021 14:50:06 -0400
Received: from mail-mw2nam10on2132.outbound.protection.outlook.com ([40.107.94.132]:35840
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231684AbhDWSuF (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 23 Apr 2021 14:50:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPX2zanhf7G18m9eTzrKJ6bb0YoAmLUpRmStyvdpoCkwbvjV8U+xEN1+JFJ+375o6BN+ZflFgndfJK0KO+jtBLO6em+xjit0WUhqd80CUM9IS/pq9A5RRoZE3kH9z3aLJTdfqOeRBcYew4SWqRdE1CtrjX/n4D84HI5rxn6mtSoPbzitU1YIyOeqX8il8HsP9Q/fr89lcsbufbu7wUf3EACnf2oAluivodvrK23RfFpf1nSuXk7jXA5Eqh+xtjSKS1+j4/vqWUuq1hnWcJI6thhW15wcvEi4FQqk+O1p05sqAc/vJ4bqU4ntc1m09nmZIMuhH9qPBkgy2yYqvB6FHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2foG2xszl0OIDL3avmVsQbv5WRLVQmKrPwrJRN7u/iY=;
 b=XmqWGYHcNt3Fk2pmgKs1jJSWhgk+QIKOL88iMAmnfforFNc3+MGrUiIdx1PljpUbsA5DxQnHEmuGeNmXIr8Yw/ntRNLcL0tk4x6bRzQl+dE34hVXaAB8KhaN6xFjH9sj/L2PhCXy+5ShDVpaaBT6xgj1nxNEgglryUDBOUfEeLQssPspCTADPolrgxwQZEwGpiaUMIfGf++vyRe9T90RxN94HGKD/l+vSTikVfURrdVN5G4vL1TytjLab46HwKrCnMnIeuFR7ymOcs/U/P6k1OQvqnHOxSMDuz7nWW4WCnwGiCU3dj0HP0FE0w+1IqOA53WeA7Pq/OAsYW4JULpvZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2foG2xszl0OIDL3avmVsQbv5WRLVQmKrPwrJRN7u/iY=;
 b=YfblkWDTFBAd59iI1kzlVoV5DEx+/XbUijkMRJ/aMwtry6rMc4e/jusc5j0wfzBZwKE7JUdH5C1OVvnI0YHLxHOPGSj9iN7z5FjktlBs6v0iNCav5qIJ9bf8/uk7KHB1vNHZVMTbV+udxJKkyQYVMnOeMY0QxUKWR6MqGU7GKRM=
Received: from BYAPR21MB1271.namprd21.prod.outlook.com (2603:10b6:a03:109::27)
 by BYAPR21MB1157.namprd21.prod.outlook.com (2603:10b6:a03:103::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.5; Fri, 23 Apr
 2021 18:49:21 +0000
Received: from BYAPR21MB1271.namprd21.prod.outlook.com
 ([fe80::c074:b476:d8d6:4e86]) by BYAPR21MB1271.namprd21.prod.outlook.com
 ([fe80::c074:b476:d8d6:4e86%9]) with mapi id 15.20.4087.021; Fri, 23 Apr 2021
 18:49:21 +0000
From:   Long Li <longli@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
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
Subject: RE: [Patch v2 1/2] PCI: hv: Fix a race condition when removing the
 device
Thread-Topic: [Patch v2 1/2] PCI: hv: Fix a race condition when removing the
 device
Thread-Index: AQHXNzrFBLwYwYTj8kqzheBKY3VooKrBsNwAgAC786CAAAVKAIAAAe5A
Date:   Fri, 23 Apr 2021 18:49:21 +0000
Message-ID: <BYAPR21MB12710349DACC3FF32CC65793CE459@BYAPR21MB1271.namprd21.prod.outlook.com>
References: <1619070346-21557-1-git-send-email-longli@linuxonhyperv.com>
 <MW2PR2101MB0892A9A0972199A2FF6D68B0BF459@MW2PR2101MB0892.namprd21.prod.outlook.com>
 <BYAPR21MB1271F9B76FAA423D7BE6DDEECE459@BYAPR21MB1271.namprd21.prod.outlook.com>
 <MW2PR2101MB0892D7E83CC44D97F4317871BF459@MW2PR2101MB0892.namprd21.prod.outlook.com>
In-Reply-To: <MW2PR2101MB0892D7E83CC44D97F4317871BF459@MW2PR2101MB0892.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=825368ff-303b-448a-ba43-6f3872c68267;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-04-23T06:58:52Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [76.22.9.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8585cb3e-fbee-458a-8e10-08d9068881c1
x-ms-traffictypediagnostic: BYAPR21MB1157:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR21MB115794A5656230057F593EF1CE459@BYAPR21MB1157.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RGpw0KLiUV9zEEMwCYXMR6diXP5OHQa9zhqHO+UhBtt5c8cX2DPCz+N48wZ4Y7PcsYZHbTka8eSQiKtRMZJT1hFI7KhNIlKqOUl4TaCSJJsWwkT2Satc37Z3RHigq9Dd8g9brqwNSxgYgewgNJPrdn+9TRFotG+rrIRQyOFXbd2wIhz8/ath4R51DNGks1gMbxm2uU94Y3s/538kRjF9EGRr1Rur8bLjr9RqnZy+Ga6bCKx6h9ZtOZrJZ2ygvyB4UOBFHHMxIltATlXvz3mGRsoYSTtDyzp1xVu5eLfPkwzeX/atg3VGJmjVfriWd8V8x67rjsDF4JZV62bmVODHWP2PUrYcvM3aZPlklWT7kif0TSsMjVxuYcw9p7Aye8qDLDpbe+HssE6gnTYxTkvKTFRmp0884U0ZCWe+aBQHNxPr2jS1nSoiL8Vl/rlet0Riy0abveS+qfKUF4QI+5aWif/zwAmdi0ylkFnxIDykdMknCz2NkUowZgfsP7wq3KAEgCCPyXvZhLhq+/C1T9wRsGEgHHsKB/nxcUNxsyNmdmk69zWtRtW5jg3d92Fk8nDoV/pB5gT+dncaOYsaJ8VIzAWtm7CbIi31ZBt5miwHpary73zJ3v6vPsM8HaFR2K5DPBv7Jd051vSAW0+fh7eVyQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1271.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(71200400001)(6506007)(76116006)(921005)(64756008)(8676002)(9686003)(5660300002)(7696005)(52536014)(55016002)(66476007)(66556008)(66446008)(66946007)(8936002)(33656002)(4744005)(38100700002)(122000001)(8990500004)(110136005)(10290500003)(83380400001)(478600001)(86362001)(26005)(82960400001)(316002)(82950400001)(186003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Tbx0V5vYqVmsTJYFDaz0pA/yVw5DSviVAnI1MZoiVX6MWzzzsrW+AQYxEqqp?=
 =?us-ascii?Q?FKaXHI4Vd1mddvzg0tm3zwHLqKYy9d5j9TDYHE3kEWtxFIjpBIYZ3wap3vVZ?=
 =?us-ascii?Q?bNVscM3SKv7OeEjMwiw8SSoh62IKxgcG1UNusxoEE1LnKA3ArLdkTa4SD+bq?=
 =?us-ascii?Q?nCRLnlT7IE4483yz+1q9ew0KTqzMNwXURoBsYZ5xc+4YIWK8o7sBXV7VX6uM?=
 =?us-ascii?Q?EFdEa4/UwfMtcIjXhO9KWVfhPj6Q5X6lKKHW9HppuMtc67XC2IJCePOc7qcx?=
 =?us-ascii?Q?4itCdzhQhzenkaFdbgjlmuBS1jxii4+kD2cgGnEaGNaammbAzg5Z8bfsF5wU?=
 =?us-ascii?Q?h0bBpHsCt3gTI/qJtPxKXc6GLBw54Yt39Qp+LyzubEITGwySgtSujakuwoVK?=
 =?us-ascii?Q?yNG/VFVWbySi3/SEAhlZB2e/xRcGU9IS220vW/b6/PJ5nKRCOtHBLYALmwHJ?=
 =?us-ascii?Q?VWIi8rrDFfwW9Bjo+KszzDuGyHJDfA1vJNUFYv1ZraWWY6g1I3lvTybjOHeF?=
 =?us-ascii?Q?QpE57aj9uj+eXmqv0TUtZm5QxBDyBmezhpigS8NmNWUwYgc8VkUZuvETE9c5?=
 =?us-ascii?Q?OePCAg91lkoI42Hh0rMmDlYs0bP1lbKlwMpl7eNRFVOZi8kuXTEJLH66qu8X?=
 =?us-ascii?Q?yqLFdeffp5r+Hn+2URzJcLTfyUDrHQ+V61zPgiI/DGCxZaAc910yuxEt5bKJ?=
 =?us-ascii?Q?Wogz1dW/G7khEXRT6oSNxsEhk4ehDLUG10kDvWsVadpz9SyjumuAsTqAtlvl?=
 =?us-ascii?Q?p1LH/FOQ+bmJ/pPJ4bpL75f5jG1R3Qr+0fcK/NDfvXwE/Fo4EYhSywYwVkTd?=
 =?us-ascii?Q?HFXhfd7LPizydZ+3oAxkim/wHa6RvM1BKLWifHm8aPSEEJ8DcguQdC4p2HVW?=
 =?us-ascii?Q?DKDDq32YTpeWOpEtWEQ8A799kwawBgzWksvMIOvrSdDiZaYhzxkR8U9avIFd?=
 =?us-ascii?Q?1a8uSAOnhaiq5MjuCq5woMK8FSdTyLvqK4eElABp9Ung3fILBK0hjNB8ibdv?=
 =?us-ascii?Q?ftVVhmvCkV5iXs8FQMIR3KQZeqHVU4rEuKtVHT9I5f2IxwEnMsRM6xDwgshs?=
 =?us-ascii?Q?sdH9Nc3CtMFa/mkwE9nNsSg+gtbfNvqAp7bcTV9mL4uhS1WpnUBrcP2/M0+o?=
 =?us-ascii?Q?zcigeJ0eDhiGST0gz22M0OalpWf0kRMOMMbTweMj2MR0ZaTHMbQvyqKlLM4D?=
 =?us-ascii?Q?HszXgTMSjzsIP8gjrhRx9m8ubz78Eh1jqfICGDzLev8SVkbS2zBwgtvpeG1X?=
 =?us-ascii?Q?yx8beDgc8pvj83va5z5aZVpnVcY6sjstqXf6Uh/PKuvlqxmXFSpsn86zb1KG?=
 =?us-ascii?Q?1rs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1271.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8585cb3e-fbee-458a-8e10-08d9068881c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2021 18:49:21.0411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2+dlfmvO8RAG6KK27LXeFXkANm89si8i7zmvPw8aETcHfp8aKDk3osZiVif3z+mrQxipRtt3nAzt/sObV3AtZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1157
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: RE: [Patch v2 1/2] PCI: hv: Fix a race condition when removing t=
he
> device
>=20
> > From: Long Li <longli@microsoft.com>
> > Sent: Friday, April 23, 2021 11:32 AM
> > > ...
> > > If we test "rmmod pci-hyperv", I suspect the warning will be printed:
> > > hv_pci_remove() -> hv_pci_bus_exit() -> hv_pci_start_relations_work()=
:
> >
> > In most case, it will not print anything.
>=20
> If I read the code correctly, I think the warning is printed _every time_=
 we
> unload pci-hyperv.

Okay I see what you mean. I'll remove this message.

>=20
> > It will print something if there is a PCI_BUS_RELATION work pending at
> > the time of remove. The same goes to PCI_EJECT. In those cases, the
> > message is valuable to troubleshooting.
