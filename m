Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEE177E827
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Aug 2023 20:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345349AbjHPSEO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 16 Aug 2023 14:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345403AbjHPSEN (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 16 Aug 2023 14:04:13 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020024.outbound.protection.outlook.com [52.101.56.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006831FCE;
        Wed, 16 Aug 2023 11:04:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dbYPbjtzOZNElQe4RRUmzq6uMhS8JiKcdil6RxlVWdLav7kxfedUCTz8phBX2ipPw1WKWfnyrBP+e4KhYWqVFGFdl5mn3XpsYeZ1WPUOlotV2Nm0/hMCk2HYke9NItqzhL+zKa0St5iSfD/atzVonzPll4LhHM7cApnzVvedkhQ6UOoowe2XM+4PZJVtsJOqdyciJ3tiodhEdWWzucW9BSMUZMG5Af4ZDiTaBTYJ83BU0YYKZwXj3cB3GGC34yXR4JhMerbgdZtwLzjyxX5XcXkJ72Cp4tx6j/Aweu3uhiyx9vPDEvJ+r4qUY5bK0psf3ymQMIdb3x76URYxchTCVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3cv4Db4g7xeYrYNnsahjzh8Ydcr4kDI3PQ07x6qcjiY=;
 b=I5uVcsQ0ZQl5t7ljgw52L3194C8jItWP0Lg+TFjv8z5ij1is/WpCHSs3cIKdqzxtizdnsxJCw1St8rnyOmM70tt9v9jpPp6wlsM4FgasT0pl4v8V73RGXstWAKuUTD+rJbm1o+0xiyiLCZTwo43Gh0xq0Q8XDMJ7AhBh/N1CJDDALovkr2iHM/1D3EsqT+/DyiryN50E/0Z3lWem91i6R87+AwF1X4q/VIZ9Y+ORrZEboeMPCh5zfyh8FTiSb5N10ZDSOReVfS7O3eeeATHlaZATDziUeS3hhOC6orUniLGGp9E0jP0xnCxNmtzPtLfTYgwZHFXoaSvgAFTAjXA/8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3cv4Db4g7xeYrYNnsahjzh8Ydcr4kDI3PQ07x6qcjiY=;
 b=YVpZpD7M+JA27sjBfj7sLYLUiQqgTlotqvCpRctONW9kH4jnB1gjHFcan6oMNDJBtSCc6m+DGcxOHyDciU9D8oT+vAzRE1LQqJahTBx7hR4ZqddNjgTU6CBDS5PhCJWzwCKI5PcDvaQHbGV2nIYIEYK6Q1wEtHeZoT6yUPH0OrY=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by DS7PR21MB3293.namprd21.prod.outlook.com (2603:10b6:8:7d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.4; Wed, 16 Aug
 2023 18:04:08 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::b05:d4ac:60ff:3b3f]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::b05:d4ac:60ff:3b3f%4]) with mapi id 15.20.6723.002; Wed, 16 Aug 2023
 18:04:08 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "kw@linux.com" <kw@linux.com>, KY Srinivasan <kys@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] PCI: hv: Fix a crash in hv_pci_restore_msi_msg()
 during hibernation
Thread-Topic: [PATCH v2] PCI: hv: Fix a crash in hv_pci_restore_msi_msg()
 during hibernation
Thread-Index: AQHZ0GuE9HQ+4XxCw0S+MyNu5t4gyK/tNsOQ
Date:   Wed, 16 Aug 2023 18:04:08 +0000
Message-ID: <SA1PR21MB1335C35101736AC02AD29650BF15A@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230816175939.21566-1-decui@microsoft.com>
In-Reply-To: <20230816175939.21566-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=065503bc-a9d3-4745-8b85-d425d3456355;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-16T18:02:20Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|DS7PR21MB3293:EE_
x-ms-office365-filtering-correlation-id: b57645cf-70f2-4601-7bce-08db9e833018
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /gXsNkVUVMj1pQjMbe1sw207k3Zy0A4OfbRCnliG/kM8DwHyb8bqtvjktPCgepvre05z8nD8sfIrX1VIDFTPej4paQhPQf+U586oRN1vBolO8YROVFtVf25Q0/dD3R3bU5QKrVHxwDtK8xbDA1NmEUVkZDQBI4OSzTimoNW/EgjDPvGjQMuhm5PHTDncE9zVfoDFTXCHWq3IMDErv37gdt/5Btzv+IMIxv6Dql6L7OFzp8QbjIjgb7W6pepwaqjZzWUetff5QLclGOvSXHDyMF2lrGoFrovvAMa0qR7lSWZXc3PvLp2YEzzQeTdrNMxAD3Z34UFsjyJxtRJjb0c76m6OQnte9e7BNwXBHkaXzc3sj92lISlCUtJofGNriv+fB9LGvmKTFxdWTERIx35+mulyN/MlEqHGWm+AxKsys2UBp/rbKPcWReWjlek8l8s6UwT1Bfe5OgHGu9YyBkuxi68WyDTnpBMM9amuQ1xA0FiN90ONu7MsdzkAKtZqBokIYLHXJ3j+ErYPcBMY8Jk3UveUeNrT1wKot7ORxRqfPLT1IxPqRrPOyHcnyeVncRoa6+wiKKHBJ6aXMglSjsUzExiGf22Sa8cIB6fUBCoBUYCfbqkU4wNBVXQqWdlMXXKliBiLADFcWQTO75DQ/IXe66Y6Lo9nayz0TlH+u98FgcjJ5cx0Ovb/c98mCYLtRg9TdaaXnWbHqWnbiWFfgguYdQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(396003)(136003)(1800799009)(186009)(451199024)(12101799020)(66556008)(4744005)(66476007)(26005)(66446008)(7696005)(41300700001)(76116006)(10290500003)(66946007)(9686003)(64756008)(6506007)(316002)(122000001)(55016003)(110136005)(86362001)(7416002)(8936002)(82960400001)(8990500004)(82950400001)(5660300002)(921005)(38100700002)(2906002)(52536014)(478600001)(8676002)(4326008)(33656002)(38070700005)(71200400001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Y3v+9fjCafWisQ7QUczfpy3qelSpt30QuupgeVOROz01J650wP2Jlcn7MMi2?=
 =?us-ascii?Q?HfoFUxmNsFV1642T+sdHI7YOcn8hMgAxORzuCkgPbvkEARKuIIKiTtMU0ygD?=
 =?us-ascii?Q?YkNUH70cX3J5wRcp1Lf/QrwatjEh6AZs8s3F/GriGgE3fl82GSBtwxKH8iwr?=
 =?us-ascii?Q?rC+lnakZ7Pab8PLiXS3ybXCirueVz0cn9z9yCDbaiEph02dDFv6RMemGTHLv?=
 =?us-ascii?Q?dBKF4Y/IG4fGdLghbCcn57I2PPjnEHw9esO+mQwEwHI/qMtuoRI7moK+TMU+?=
 =?us-ascii?Q?z9xGDkWmeVbmCVFZ9Z40D+gZjt00R18VRbftc0K0RTtBwXPWZ12KeW70CxBe?=
 =?us-ascii?Q?zx4xAMNokPuPbHlHBLPDiyJMrmYAS6RO6tuahDFD7sor7Lb1tIDGoysCzpcj?=
 =?us-ascii?Q?xQBkK65kM4I/CGYQ4N9B86KE4wcOZN3fQorrI9kgFQ2kHHG9p9cdSe9hcOG2?=
 =?us-ascii?Q?JLN5hjnyA4hskZPMHReDdo6j6D/tVuIwZWy+aMXgGsih0RNM8wRPJfjNwocN?=
 =?us-ascii?Q?+cqhRYjuuYr/aDsqVNOytx48DwRPyvF9WzZsSV5GIpfTxfb3Puwf4++xuGGx?=
 =?us-ascii?Q?V1MwmBO+d6K/6tE0Pwcen7zBfuC09IYjE8srnO4Up+19vn+jrMWEZ0HjGuZV?=
 =?us-ascii?Q?+xzOAMwutnegPScDQFGUhG+p2qjouL3Gv+R2QM72Ea3l0AR44jOi7QrVt6aI?=
 =?us-ascii?Q?NYqCCcYqV4Fngrp7UU5quZYahBBy1r+NEGK0XoR3J6Oe0BP3BNhdx1XpGfOO?=
 =?us-ascii?Q?0oI5c9VsiFgMa5Kq8NWOvHwZL1QmyQCT9WtraInF3iJ4EoirYs9MZFcoRKnu?=
 =?us-ascii?Q?HmrT1NvS63ZOs7/bKnUrQgr7eEN5yUDjLNFyzF3rcltHbC7BYVhotJwaF4ZS?=
 =?us-ascii?Q?q50VQG382LFeQNNHlunMOriGZLzJmiWioLHZZbqOiejLZs7dsPHWHR/ezfXx?=
 =?us-ascii?Q?SVd0/ED/U70lzX9CkPNVnfslKT1SnCQdPRXHUEZ/AaLu2xPbhQI+kam+gIvu?=
 =?us-ascii?Q?LvzMT+41WjKUZMV9A2JFroF5sgPQgt2Es2Y2Ic7p5Qrzsp/82jXrEumN+EBZ?=
 =?us-ascii?Q?6LOUB9MAdkPRzeeK5aYiEjNU776dfg1yK73vKj5zVCFYR+94xV8GEgvXVU+L?=
 =?us-ascii?Q?XxS6kkKiRh1Md0asENQshKC9aHkmUG75QXnPDNdMnxJr18PyicPCBuUonG7M?=
 =?us-ascii?Q?Esk5F7MRaLyshyGMx2L9ZqB5R8/RgsBgow/2efmOUmSRHQsSe10RQh0uwOw6?=
 =?us-ascii?Q?ydDNbERAAz7qv5DVb75rEipj4EdWsIqc1QWujK6XTsyzYKf3xZs1/c2v7u+R?=
 =?us-ascii?Q?sK1pt8aUUyu/q/9HI4YaAY0TU7yTUjgly0BPIZIGTH0/Wy7hdk+UR6/20JcU?=
 =?us-ascii?Q?+j4TZ5USjHM/x1uUh/p72oSzS2VgoqK5ztVBiYLCBirosddHaPEr5hz1y0ky?=
 =?us-ascii?Q?iznLusoWq2FpBZ9b+MBbssOjlEKzZOYtdc/CfUvaD4nVoQZ7Jfo2pwprB/PN?=
 =?us-ascii?Q?0pgu0P2W6lsHibz7JDqAl5skiu7UnSM/ufxgT3/dkC/YccXEB71ZgsV0dpvQ?=
 =?us-ascii?Q?Ak6shxSOqhuKpA437c2wFyD1XgxTQzpICa91PmtV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b57645cf-70f2-4601-7bce-08db9e833018
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2023 18:04:08.7658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e70YxGMOgCWcsKlmSdJOrKWW7VgeK3nIzF6AwR5lz5QOO9FSnW5GiLpORX2M5kQoIdAFf+KcwnDArKL7qg7QVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3293
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Dexuan Cui <decui@microsoft.com>
> Sent: Wednesday, August 16, 2023 11:00 AM
>  [...]
> When a Linux VM with an assigned PCI device runs on Hyper-V, if the PCI
> device driver is not loaded yet (i.e. MSI-X/MSI is not enabled on the
> device yet), doing a VM hibernation triggers a panic in
> hv_pci_restore_msi_msg() -> msi_lock_descs(&pdev->dev), because
> pdev->dev.msi.data is still NULL.
>=20
> Avoid the panic by checking if MSI-X/MSI is enabled.
>=20
> Fixes: dc2b453290c4 ("PCI: hv: Rework MSI handling")
> Signed-off-by: Dexuan Cui <decui@microsoft.com>

Sorry, I forgot to add=20
Cc: stable@vger.kernel.org
