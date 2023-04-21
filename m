Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5136EA10B
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Apr 2023 03:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbjDUBgv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 20 Apr 2023 21:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbjDUBgu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 20 Apr 2023 21:36:50 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020024.outbound.protection.outlook.com [52.101.56.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4D93AAE;
        Thu, 20 Apr 2023 18:36:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VAmuLL3weFqOVmIvfvbP2Oo1ycFZNqX70AtGLEngLI+Hj/9YzpWppTtdg99WjHZuHutNB3IQOGSZZK4d+N9yEGrcmpQOfY2QujQu1hYobDH2wR64WGZjx/xzlFDu5rJAulAXX8+hfIGTtIoJ3qvCwzdjPe2bbzd0v8opQpDjZEYywgpNIHsYuP+ebYEXC5IJuhMKXrs15fkYKU/Va31WdyXJtfuvJm0NWq2PxW3mpxVoN8oxrF6yshA1ldnbVM9BY+RNG52y/V6SFP4+AD1beDmOssObSiWFLuL3my5ZVq8pJLsxEGXom+xoLqj5lqL6HeMSbTM4RuauwrjCpax6/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFSQdUIghmarDDRFxa3gp8020PnyjEYUokKe4ok8I3o=;
 b=YN5coG7cww2SZ49vLxF6UQBZ5c56nCQmpA2la9fyOa6oGp02/EudXdQT8uto3HZWap9O015b+KZxwqqZIeTYh8ODjX+Jqe0NqHGKZL7wTaAqDeWiZQ6N5zYTBaIo+Ksf2/ZM3gvHvqL2/ViH2nq780ZH5a+RkEcwlwRYh+mY76EsK547VBuJfrh1VFeTrrLHXv5S2Pn9cpXALc76U89s/+yylzs+vK5Sl2e62QDxnZAJrqSo0w1DZI8pEBXiRXPFZ+Gi9W2qLjzjidd7VfPpuoLn4z4Sq3sjbHwl2tQuqiczUINFYo9KWNOePFfE/cNc7vLoOHDsPa8+0zGjS2Lg+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFSQdUIghmarDDRFxa3gp8020PnyjEYUokKe4ok8I3o=;
 b=SxLcM0Yp4JFaU61/NifFloD4nmyO+sK6cSYA4nNMuLpQBlx3pYoaEgC6wcIvUOOtpbQ1BxoXIkYWzb37lkH6fJ2Iye4ExwG7nHUdkUiO/05qbk9JUH5kmpYDUz09aK7T285oVnlU9nUfubisM4TqgtOBaW8mxAa1dIYBIHi8AV4=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by MN0PR21MB3776.namprd21.prod.outlook.com (2603:10b6:208:3c0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.11; Fri, 21 Apr
 2023 01:36:46 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::eeec:fa96:3e20:d13]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::eeec:fa96:3e20:d13%6]) with mapi id 15.20.6340.009; Fri, 21 Apr 2023
 01:36:45 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PCI: hv: Replace retarget_msi_interrupt_params with
 hyperv_pcpu_input_arg
Thread-Topic: [PATCH] PCI: hv: Replace retarget_msi_interrupt_params with
 hyperv_pcpu_input_arg
Thread-Index: AQHZal7BSHLzKGubX0KU07XgAcb7368mYESQgAIdKQCADJCQ8A==
Date:   Fri, 21 Apr 2023 01:36:45 +0000
Message-ID: <SA1PR21MB1335F2B44DBF989580A96DB7BF609@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230408211112.15235-1-decui@microsoft.com>
 <BYAPR21MB1688F1E184FD1A914637EFB0D79A9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <ZDdd0FZT9RHfg3cm@liuwe-devbox-debian-v2>
In-Reply-To: <ZDdd0FZT9RHfg3cm@liuwe-devbox-debian-v2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=29dd8a41-ea24-4f96-9c0b-3326879a8fa1;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-04-21T01:34:07Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|MN0PR21MB3776:EE_
x-ms-office365-filtering-correlation-id: 714dd96c-6d04-4725-62ec-08db4208de01
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0dav3ERMMcRDfDK9Y2r9qQif4g5R5X4pmQhwD24j9iuQoxXanwWuvF7X9AbCZiRzAiZbQo1yRw8mZjMFnEPBvgFf6eir8rka0X7nEUypiDlLc8FQBEnigVTrFcIFi/rilHas3W4dvuo+NCUPt+MudtNB8rGT+MBi3aoiv9czRPD0Qo1toH5ePj1/M0J+oSg4IDhHaF6j7XfJBfG2+QKWc4zZH3onjCz7poGlecn+GYwgvTCWv/A4Oy4u3rMQk6ihSrFbTDOVOg3L95AswG8X3D2iB2ynlf/d0jQ02QK1owif3adIb0OMctR73kEinQy3h9K0NIncFb4m4bgTNlx9HmAF1fayAJEeBHlcU28I0Yiz40zs3v8SKVJpAthlpZwx0GAQKLtzHBAJax5cJd4SRxffTcAEZyBeiBCdcM5XnQAnH89M82FxNG2zjLwg8gbKnlwosrbz9vG7n3sCwMfC0ksV74NOPPil5fC0TEnAIHnJMVAXjECLRpBNFIMv6/3/xvOBGTU4X5I3ambGukRj2kNd2y19UXrPkIJRmJCof/ZTl7ukIA15Pc8TtiiMVNlfSsJXjTrbsBoUU5LdgVyEA9QtiXGQyYSyrlm1KSDuNmp5MvqpZcAElfzEi4YPdkYoGvxXkFzjjNgUJwExv2sAIA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(451199021)(10290500003)(966005)(76116006)(786003)(64756008)(66946007)(66556008)(66476007)(66446008)(316002)(6636002)(4326008)(55016003)(110136005)(7696005)(86362001)(54906003)(71200400001)(478600001)(52536014)(5660300002)(8676002)(8936002)(122000001)(82960400001)(2906002)(4744005)(82950400001)(8990500004)(38100700002)(33656002)(41300700001)(38070700005)(26005)(186003)(6506007)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?57yohS2SxlXIRd0JbulR58NOe02UR3DAY6Mxby7SNXb9uftVI8ujvbY+6HGH?=
 =?us-ascii?Q?t//IO0j91qpY+tnIEVlv6Uyf3iApNqVI0t3iw6FvhfONv6+TUjzb8nWWG03M?=
 =?us-ascii?Q?cGBrO7PC/j9rmxkrBlaKLzQuOftL3ilaBIhovTdNOYrN48UveErFHmk8auqd?=
 =?us-ascii?Q?iEVAAiCalO4O3mZ1F762fG3BdGl7ZQhvJZeW2Hz/ohB7dPA3OJxv3sUD4mGq?=
 =?us-ascii?Q?kfV15U2tezzmzCFzk7TOtXD64HsriXFBk+c11+wiBNfF7GrMoS7mhZkqX1mI?=
 =?us-ascii?Q?VQSZks4ca6bEGCriH+OS4qbitkYaQEibm6L+p33/0JjCQaW2LOq+E0C4/FyQ?=
 =?us-ascii?Q?npul19Va4GV1cI1aqNMHMlD/DKu9J2gNACBtlMTRco3Goj+CYFr6gpDb13wN?=
 =?us-ascii?Q?F6TbmI9gzPB5xHWtCR7LI/OVDmiSQXZ2Bq0Ztv6bNB0kVT4WgP5pTITfNkDi?=
 =?us-ascii?Q?nEpULhufvZ45DzGuXwjk8GcwYLQZ+6cO1/beMvcxYIlxTN2mZuEZRI+Ea6KM?=
 =?us-ascii?Q?oU7PXkiK5uBKaddPvUXgfddBJP8GUTRGpQRDbIuFRy0tN6IFz4JCw+OG9vMQ?=
 =?us-ascii?Q?0xMA/fp95wqUYztf3B0gmmb6QtifeuDQ22hOhHLkTgOXwMxSSEyp1gJkmigV?=
 =?us-ascii?Q?8v+y1MXUOSuEb2DNsUPDrWt024i0CraXirDtIN0LAMc11soCgpC5l2zmRyzr?=
 =?us-ascii?Q?S2R3fzlEa6bmV6LyWYaOSvP1uN2BKwTPyBTiUxnBFMlxcLlqXfOqj1AuZ9vV?=
 =?us-ascii?Q?2lAU/ATcjmAoNOEwb760ZV8ccsC3tAZ+CysdQsz2HmcKtAH5+VmcZGRc2RkQ?=
 =?us-ascii?Q?qJcFWvxgS0nwjxwOyo1MhsVMsp1EUtSNrLwFKfc92fQA/MXYN5NygIqkZw5M?=
 =?us-ascii?Q?HocKAdaEk8uL6L7I0IZcdOtRbmXDofNKRHuRM5XjgwB7i0KQt+nF+iNtoB/H?=
 =?us-ascii?Q?Teb4rwbZKzz+Nv5Wg1SPL5SPW88kGs0NDAoJyMOS5sM930muv7H9wh2Er9Ui?=
 =?us-ascii?Q?I2lMxgJ0CSRbY7Gfg1gX+GMkFvUTCFStY/4F6r50C05GvxVvhlg86nQVx2/p?=
 =?us-ascii?Q?n4olepOEcvL2sRPjxmqzVDccuA31xaCPs+49dlsJXKNF02v9p9El5cfqAEy4?=
 =?us-ascii?Q?zPpaN4jOEazwOffVpTPCB4NrSPePb9GJHlhruhDrYmcQPVBMn8/y8zwB6uak?=
 =?us-ascii?Q?ekcJ4DRgQOy5V4Ac4mnjT8BwmP7VhQVLTiopfu6Oxwnd0XNm26IH5hipyN3m?=
 =?us-ascii?Q?W2ehU77hp+6vn/Me+a8vvHVOVO72Of37LBdugALOCfuTkErAsHmKWwjAqySO?=
 =?us-ascii?Q?efdYLmNF/xCqv5HCDO0fgzjvch4m32Wnb4gG7hHuNBMBthgzT4bNb0vcUPd1?=
 =?us-ascii?Q?660uymdUd/9HEkuTc0mIUruU8ni3lX2r/oQjqA3Id41lfmH6DtVn5pZ9emdp?=
 =?us-ascii?Q?sy444HOgBrKHD+0IpyeWuNSWidFLj4AvgwiHzvBIFWkrtwogV61IENpZtWGx?=
 =?us-ascii?Q?HILMDroU2NrboGi6KbKZ4havT1+eu6sNJmrXfNVFjzQuRoDYeJ8mDO+1Vuh9?=
 =?us-ascii?Q?In8Ubc2lx/WboERcLU9YkkrAmhYlEforWoei00CC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 714dd96c-6d04-4725-62ec-08db4208de01
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2023 01:36:45.4842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nZeXOvs9XeloZc++0KzFfQBtE9jFdkqTMau61K7rgyb4Gh6kSZIoGInuvPstRGtOgBlmC8bHAZdIMkkP9MgzJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3776
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Wei Liu <wei.liu@kernel.org>
> Sent: Wednesday, April 12, 2023 6:42 PM
> > > ...
> > > The change here is required for PCI device assignment to work for
> > > Confidential VMs (CVMs), because otherwise we would have to call
> > > set_memory_decrypted() for "hbus->retarget_msi_interrupt_params"
> > > before calling the hypercall HVCALL_RETARGET_INTERRUPT.
> >
> > Well, not all CVMs.  It's not required for SEV-SNP vTOM VMs on=20
> > Hyper-V because of the paravisor. Is it more accurate to say=20
> > "for Confidential VMs (CVMs) running without a paravisor"?
>=20
> Let me know how this text should be reworded.

Thanks, I just posted v2:
https://lwn.net/ml/linux-kernel/20230421013025.17152-1-decui%40microsoft.co=
m/
