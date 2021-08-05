Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C319C3E1B2E
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Aug 2021 20:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241128AbhHESZP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Aug 2021 14:25:15 -0400
Received: from mail-co1nam11on2100.outbound.protection.outlook.com ([40.107.220.100]:48241
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241076AbhHESZP (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Aug 2021 14:25:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OHubmIlZbWGh/pI5ZGmYzd+lZqegVd3ISyKuUVPDyh8z9+7Ft0iwW9tEyW9MKT9u04/XL40cQjv7m2NWJQQ7XBdDjVZkBljt4KOii/Z1OAVNRqasXetYalXyaHrZRmC0wHcquqWMyfQD7gA50ufaVzID+bnQ+P4ev4rXtGIQ2lmwbecrCLZ2BKVv9sQZnPhNSLzEm+v+EiKxS0YCWNEllP+hu5PQw39MF1ZGRLb6smytJ24AA2VW2gRW48VJ0Xhw4GIvu52XfU0Lg/sT2ZkKtI2/mDCHV83GsYxfyijfyoIETNmovVjEtL6qqRtciA4MTXG5RjazRqiYNsMPLnSdPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHsu0KwEyR7oLT/9sg3AScF4UiJEeJxMp5owjspmB0I=;
 b=YryVjuJHrc0rBr9g4vQAdYw1JUZ6VNSDutQOQ6NlrSLF7vwFhXWV/RquW9ZyqG1W/lE0NnMofW4dwKKELeM9DBHiBij6cttBuApNsKw/pzOaFBF6d9wd3HMXYhvI5vYzdV7ReeLyPcPLn8MwiRZmZEfWoRk8zsDkwN8zpsoorxlzGmXeQhaMLswjEqRds3WRmDbPdAIUPxLEI8nwxbBooZeL+reJunJuIvOUqM5CB/PhokraFWtipdhJ8v1tmzb/yLWJ9z/5AeREllP3TC/jvhlSzXxYMg29g+B1mU8cK8peynwW8eBGjj9Geu8AWlaGLiIX8kppRInH/Ear6ZZ7Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHsu0KwEyR7oLT/9sg3AScF4UiJEeJxMp5owjspmB0I=;
 b=NIsOCxpfUQWrk19tFpm4xDLpLSj6l0gDPw/VB4B+A3/jqL+fb/WiapAW8k91pR//eAymnVPJ99rChwQz72kRJ30MdngyAXNtCeRZiybs58B0+J8IB3UM76MD1WW1Uf6YT1EK3glsT48geNuBOPqqd740GWJ5hYXP1Pp0eFWctqw=
Received: from BY5PR21MB1506.namprd21.prod.outlook.com (2603:10b6:a03:23d::12)
 by BYAPR21MB1671.namprd21.prod.outlook.com (2603:10b6:a02:c2::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.2; Thu, 5 Aug
 2021 18:24:58 +0000
Received: from BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::75cf:f11d:d80d:dfd4]) by BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::75cf:f11d:d80d:dfd4%2]) with mapi id 15.20.4415.005; Thu, 5 Aug 2021
 18:24:58 +0000
From:   Long Li <longli@microsoft.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     Jonathan Corbet <corbet@lwn.net>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Thread-Index: AQHXiceSNIn8c8rqq0aMs/Uc2xnVEKtlJaUAgAARXqA=
Date:   Thu, 5 Aug 2021 18:24:57 +0000
Message-ID: <BY5PR21MB15060F1B9CDB078189B76404CEF29@BY5PR21MB1506.namprd21.prod.outlook.com>
References: <1628146812-29798-1-git-send-email-longli@linuxonhyperv.com>
 <e249d88b-6ca2-623f-6f6e-9547e2b36f1f@acm.org>
In-Reply-To: <e249d88b-6ca2-623f-6f6e-9547e2b36f1f@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8e410e5a-ef3d-4b77-aa35-d081f52847df;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-08-05T18:11:18Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 409f0bdc-6e52-4007-f311-08d9583e549e
x-ms-traffictypediagnostic: BYAPR21MB1671:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <BYAPR21MB16719DCD73988DC2522DA396CEF29@BYAPR21MB1671.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qLElPlGfG+YPkFs3RPOoxebVM7bwhxyVAK9+N5rZh+u6DqipAfCFhbfLkYMFbG7rMB4igJEG++izhjuQi678LV8eZnRUdhLuYglcLc34ThGIIBDFgTe0PEHTNA5wWCbzjk++jrWSD7A5WmlbzASKyniTJ+r4FvfmvlHHTCHZ7Rue88jyKWZJeoYXKoC7mkdndOD7n507zyn+UYd4iDZzC77psnVUPduaCklEBjtw1Wb35PeTA3X1bD4BnyHRElpG3GVAU19bokL3uoY53OwLSJ/0prl2AF8zh34KOqRKtTCbVIQ+U9W1xUVaAHo833G6erdxC8mjPXVrQyyWcDnjLnuHwMESYghgtPEfyzrmhHfrHkTQB/qfO9flBPCRRXSmtIGMOOpbro6XBg90Fk/T/z7MBAB/DEZa7aI3CGA7XsuT1A7B7avtP1IUjxm6dWbA4wEvTsU/Co5Hhs0QwcZCM84Ki7R2F/E3xL+hn7fkuakLIM49q3hrZvsPy2DSOGsnLcaSNw6GBSuhr/n0GBh9hIDQGdo0nEEwFm0j7FL7+37Ot7vhzxLT9OWVdJLYDa6i2CJ8Z+I12HuuE9IFD9b9j9K065RaIdPSdV38X033OSgZ1Y65QiL4f2/OJyS00i8BZy/JWOcWPmbcjgLejW8D5CiDdLEt4w2bhF4+6k94q4RUniYiO5b/V1XsdHAHCJwWxL1+dty2H7Ri4BAxiXAUOXLfm4dzjkt0if6m74LP+TYLXDAGLFXzE90hRrKy46ogaLyrLniye8TSI7A+ffTD9A7n06oMj3TgfjJFB4tL4ag=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1506.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(47530400004)(966005)(66946007)(86362001)(76116006)(26005)(66556008)(64756008)(186003)(66476007)(71200400001)(54906003)(66446008)(8676002)(8936002)(55016002)(52536014)(110136005)(122000001)(5660300002)(38070700005)(33656002)(83380400001)(7696005)(316002)(8990500004)(508600001)(53546011)(2906002)(7416002)(9686003)(10290500003)(38100700002)(4326008)(6506007)(82960400001)(82950400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?85WT5p64XOhnrje6pPeKMqyNLywM6gkbkiGUDJOWY426HRUywy8jeC5/YO1B?=
 =?us-ascii?Q?x5Cj6C6O7r3MqamQA8JGDTK/NGHLGq2GqJ4JDlQXJvnscwOBQZu+WwYuM6mC?=
 =?us-ascii?Q?JAR9Ki9UwdGHeDZAKcCCu8qtjoQA7Q4M4jyfKua35fmU8KFzYuvfNz2wYEeJ?=
 =?us-ascii?Q?GuhGaMQTlxGyzRzHApyxsA/t0t3I5zyI6IKMGqxTEObgAuYAEMAJXbREN/rn?=
 =?us-ascii?Q?A7hiPIYklLCGJNRJHVDGTqwEWXhCoB5ahUNktECHpw4hQJFafPLgjAfMU/YE?=
 =?us-ascii?Q?JFZQVRQOp8L597hKZQBBRzsV32fPaEfJEOu1wigROykn/0b5TCin6YJ+Hd2M?=
 =?us-ascii?Q?vk3spw+MvCxJkD3cUIdwM3SEa5bboTfBv/0Zx4Z2UDksl3fD6m9bGTeTNaa3?=
 =?us-ascii?Q?3SyqZIwAs+sC0lllwA8SjNCrNeQueM31UuWlSxSilPRwfVUThtvSUfM174Ku?=
 =?us-ascii?Q?SBJbDsntTd+/m1rc6D76KckNrnVIlxXY4e4OAhfg8/mIXKpPkl85tRzxP7Nk?=
 =?us-ascii?Q?JQr3m2IkkVZmGZvvfLnvFA9QF3VeGeNATtZYaV22mwz2wXWBHMOvumD5PqHF?=
 =?us-ascii?Q?gIltDm1EZfbb/isjSlePSTCNz/R3776ojnIJ02c+FqSU/n2WZt2UEsojyoj/?=
 =?us-ascii?Q?G3HGyCqYefX18jnXUKythbNGQe3vIQHMCDOsSHfVOng7d0aGjeAOTGXGF1Ao?=
 =?us-ascii?Q?A1AjNEF1WnzVTQVoIPPeG+bGd3lnFyrdQTHW43Wp8wCdL4aBJZP7aONSCCc9?=
 =?us-ascii?Q?TI7wRjVR338eMibfkJ6HKiubTKn1CnW08Srbq57qSSyRToPX5374tb9FhXtK?=
 =?us-ascii?Q?yBdFzXfXr/p8VUMpmXdBij4zjJrl3lBscOCnIA+0V8MtCWDWsMBg7+FYVDhQ?=
 =?us-ascii?Q?Nq3R0qnQ8ZdRNPllh1ZyiHHVUF2CAojzZvj/fHsn7/uG5yzwphyNPjet1Kg8?=
 =?us-ascii?Q?S5wpKxWC2K0W+lNxtZ2xqIFeFZPhXdNc00UCcvFVIixBm0U7rRNfxZAaai0f?=
 =?us-ascii?Q?MZBORUhqLx0VExIjtflFvQeBK85Alsu4vf/qjLPpbZ/0JvtyNdIVog9uxXT6?=
 =?us-ascii?Q?e8xfmH+eGplLYt4OGCk/I9x1FqbX/09rzW15358NaJp4zDmyLDaWTHleZU6M?=
 =?us-ascii?Q?OTIz+mtK7TXRBliZMuhJ5IptIFUc7HJn2LqKsM3TVlDlZU4CFQbi3rLSjXPr?=
 =?us-ascii?Q?QtFWVAhsfv8oQ7saycYTNsLldXRJENTLxF1AGNHWFp6lOQExIoNGuLP/izy9?=
 =?us-ascii?Q?izKaSWEYDUD3vS75FPYVOOoRZQPKBU0DOt7oJGUtZHvLdwfsTVjdAjZ72JZA?=
 =?us-ascii?Q?vXY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1506.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 409f0bdc-6e52-4007-f311-08d9583e549e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2021 18:24:57.9171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LL3lSVEUzk7/viQqrY46dcgUSvOWadoXQXj4h4E1KuS+4siX2HBGU9nvpPJFL2iq/a3QyOYThSlVEoSBsivDGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1671
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: Re: [Patch v5 0/3] Introduce a driver to support host accelerate=
d
> access to Microsoft Azure Blob for Azure VM
>=20
> On 8/5/21 12:00 AM, longli@linuxonhyperv.com wrote:
> > From: Long Li <longli@microsoft.com>
> >
> > Azure Blob storage [1] is Microsoft's object storage solution for the
> > cloud. Users or client applications can access objects in Blob storage
> > via HTTP, from anywhere in the world. Objects in Blob storage are
> > accessible via the Azure Storage REST API, Azure PowerShell, Azure
> > CLI, or an Azure Storage client library. The Blob storage interface is
> > not designed to be a POSIX compliant interface.
> >
> > Problem: When a client accesses Blob storage via HTTP, it must go
> > through the Blob storage boundary of Azure and get to the storage
> > server through multiple servers. This is also true for an Azure VM.
> >
> > Solution: For an Azure VM, the Blob storage access can be accelerated
> > by having Azure host execute the Blob storage requests to the backend
> > storage server directly.
> >
> > This driver implements a VSC (Virtual Service Client) for accelerating
> > Blob storage access for an Azure VM by communicating with a VSP
> > (Virtual Service
> > Provider) on the Azure host. Instead of using HTTP to access the Blob
> > storage, an Azure VM passes the Blob storage request to the VSP on the
> > Azure host. The Azure host uses its native network to perform Blob
> > storage requests to the backend server directly.
> >
> > This driver doesn't implement Blob storage APIs. It acts as a fast
> > channel to pass user-mode Blob storage requests to the Azure host. The
> > user-mode program using this driver implements Blob storage APIs and
> > packages the Blob storage request as structured data to VSC. The
> > request data is modeled as three user provided buffers (request,
> > response and data buffers), that are patterned on the HTTP model used
> > by existing Azure Blob clients. The VSC passes those buffers to VSP for=
 Blob
> storage requests.
> >
> > The driver optimizes Blob storage access for an Azure VM in two ways:
> >
> > 1. The Blob storage requests are performed by the Azure host to the
> > Azure Blob backend storage server directly.
> >
> > 2. It allows the Azure host to use transport technologies (e.g. RDMA)
> > available to the Azure host but not available to the VM, to reach to
> > Azure Blob backend servers.
> >
> > Test results using this driver for an Azure VM:
> > 100 Blob clients running on an Azure VM, each reading 100GB Block Blobs=
.
> > (10 TB total read data)
> > With REST API over HTTP: 94.4 mins
> > Using this driver: 72.5 mins
> > Performance (measured in throughput) gain: 30%.
> >
> > [1]
> >
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fdocs
> > .microsoft.com%2Fen-us%2Fazure%2Fstorage%2Fblobs%2Fstorage-blobs-
> intro
> >
> duction&amp;data=3D04%7C01%7Clongli%40microsoft.com%7C6ba60a78f4e74
> aeb0b
> >
> b108d95833bf53%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C6376
> 378015
> >
> 92577579%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
> V2luMzIiL
> >
> CJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3Dab5Zl2cQdmUhdT3l
> SotDwMl
> > DQuE0JaY%2B1REPQ0%2FjXa4%3D&amp;reserved=3D0
>=20
> Is the ioctl interface the only user space interface provided by this ker=
nel
> driver? If so, why has this code been implemented as a kernel driver inst=
ead
> of e.g. a user space library that uses vfio to interact with a PCIe devic=
e? As an
> example, Qemu supports many different virtio device types.

The Hyper-V presents one such device for the whole VM. This device is used =
by all processes on the VM. (The test benchmark used 100 processes)

Hyper-V doesn't support creating one device for each process. We cannot use=
 VFIO in this model.

>=20
> Thanks,
>=20
> Bart.

