Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0ACE3E36A0
	for <lists+linux-hyperv@lfdr.de>; Sat,  7 Aug 2021 20:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhHGS32 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 7 Aug 2021 14:29:28 -0400
Received: from mail-co1nam11on2127.outbound.protection.outlook.com ([40.107.220.127]:13281
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229565AbhHGS31 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 7 Aug 2021 14:29:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bleyIjDKH+TH5SHeb5bvHl0rIKG7pEosKG/ufKrLE/nIIK9cjUZUecIATjenT9r8Vah16W7zAof8Yypj1xQIQjAGbdyMOXcSZiQSHw505w7P6X6FTz0OXjs1dhW0Y3kEaNUxMcxezZy32KOnx4o/+nO/YRD06YSmh1/0vkbq3O87OKU9hPI37RKRADFz4IpQgyIvdhTJ0xDI8jnde7u2UCsAQo+et8QNds4N4HrSM6WkjFFD7FlO3hH/ezKLruObQ7ckmepf7CZsAYlokcbpWvD5R8qG38QudaIAnz7aRVt+u6jLhP3r1hhHFxUoogO07pCI6uMLxveuXnWIK8h8rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srv27vZmcJMiNEGIUzK30wVffz35JsolBeCVfOW5yLg=;
 b=cV0iJ6WLoduXaGfd8PsENJQ3Hjs90hfaBsAgS1R3J1OuUHIRm9JvltMx5g8GLzFMZ0X1u/4AT39ZLv7oXipAMK4j8I12Pg18volAhax25aeMf1pYxQSJruDxO0XguNVbL7xOix8GhR9s4EZK6w+xE3C0dqI5OteB30d/j2Q3QxiSvmtlH1SZYGleDjK7cz31mArAYGJM7VNNYGuzaTsDcpw5+Mg/hwTBSMagSwgU2neK4kpDh0nBc5lsz4QCQsRBwpPysFuxUD5rl7TIF49Qcr90nxRS8qw2jc5drmSNQzRV4p3CtvC7dHXe/lzuUYhtMU4JNKrhFgyetZ3IJuekIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srv27vZmcJMiNEGIUzK30wVffz35JsolBeCVfOW5yLg=;
 b=Ar9tpwlDfGV3cy3HXH1Jg5AQAu/3GXYPV0I8aplEkBOZ1lvypicHlJMQpuONok6vXgKjDnTwyNANJRZe5fhC3pe4VkHO37ZMCdMSma6pXBZNczzryUQV0kSBVWuLWTbt7Mhh99helXrmryLTyVXokGZTzDl1yVfoUmBf1p5uvoU=
Received: from BY5PR21MB1506.namprd21.prod.outlook.com (2603:10b6:a03:23d::12)
 by BYAPR21MB1224.namprd21.prod.outlook.com (2603:10b6:a03:10a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.1; Sat, 7 Aug
 2021 18:29:07 +0000
Received: from BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::75cf:f11d:d80d:dfd4]) by BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::75cf:f11d:d80d:dfd4%2]) with mapi id 15.20.4415.010; Sat, 7 Aug 2021
 18:29:07 +0000
From:   Long Li <longli@microsoft.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Bart Van Assche <bvanassche@acm.org>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
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
Thread-Index: AQHXiceSNIn8c8rqq0aMs/Uc2xnVEKtlJaUAgAARXqCAAAZzgIADIFJg
Date:   Sat, 7 Aug 2021 18:29:06 +0000
Message-ID: <BY5PR21MB1506A93E865A8D6972DD0AAECEF49@BY5PR21MB1506.namprd21.prod.outlook.com>
References: <1628146812-29798-1-git-send-email-longli@linuxonhyperv.com>
 <e249d88b-6ca2-623f-6f6e-9547e2b36f1f@acm.org>
 <BY5PR21MB15060F1B9CDB078189B76404CEF29@BY5PR21MB1506.namprd21.prod.outlook.com>
 <YQwvL2N6JpzI+hc8@kroah.com>
In-Reply-To: <YQwvL2N6JpzI+hc8@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-08-07T18:29:04Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1e7a16cd-6d10-40df-bdee-7b0688b16824;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73344fab-ffa1-48d0-f218-08d959d13de5
x-ms-traffictypediagnostic: BYAPR21MB1224:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <BYAPR21MB1224201BD30AAFDD88913B96CEF49@BYAPR21MB1224.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X6BYEvl9pIjRFAKO8hmobQQduv9sf69biz+8TDBktxH1HH7jb0cMBir9NCq8AGoXju4fYVzgpu4QQ+Qu5fq4gCFaxsMq5SFp6Bfd15x/+LyJMBP4PWbJv/d8dRM1e/SlsgUG2GEe5qqvJS369KHE/sF0oDS10r1lsPI83az4oGCfSKrfW98ErOagTsca3ATAvXzY/P+wjOHotOt6AEepmVNk69eYB833uPOpcDA8o1+D1d2eJWWUsSJBVT3SphJEcHwPa6j0/wVK8ABuhq/L61oVJlYnrvmR0fC28I+DRSl41/fdVi3m/ryanMt0ACtZylmiMcru82umkk6qryoDA7AF0r0ib53YF9EzNaykFo6bTSgq6M735HxT8RgSPUxzYvbBVbZV63Whlu89WjoGu/8SzQBGLcxeVE/gHv4QjWV5CfJNP5pWaETrVZy9RvMHpuuVGo11yUqwPrKLn/qBKybJhYB4ILYsULBiqGH7+olKtmmU9rsRMR5J3P9ZrBk/t4EcmtfFDPMV0qZZbdMPZwhCANjroXTXDVqT74gdzJaUuwHbisibXmVrPCyaEu6eQ5oB1L/S78ss7oVuVymHiQzqrWOrwnZ/EpCjNLF8IOc6xcMfehZRDHQZGmm6BC9Hvm5FNBndrvIucvnxYgfoCfkOX1MmwvAqS5yBTNEJGE+mgDkgFceP2aMyUOo6FCMnDOhqmYlNuCfioNy5gceJGsmFjr86vqBsk+fiIqnCYfL60U4QlruMaLhjeQQTGC0E/1jvMbiVUGWzrLvKKOypwNSxN995k9ZVtq33H0AJKZ+qEKspsWL+zbbK0hs6eyS+yipbuo1xApQddMCpRZS63w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1506.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(47530400004)(966005)(26005)(186003)(71200400001)(66946007)(38070700005)(54906003)(7696005)(76116006)(122000001)(52536014)(10290500003)(9686003)(7416002)(8936002)(64756008)(316002)(66476007)(8676002)(38100700002)(66446008)(66556008)(82950400001)(5660300002)(6916009)(2906002)(33656002)(82960400001)(508600001)(83380400001)(55016002)(86362001)(8990500004)(6506007)(53546011)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KY0Z/CwIYux66/o1dTu0+aQhzQoSi+2FHY6WdCzmLdnJCHCJhpSTTnuKo87I?=
 =?us-ascii?Q?YdX85qusiG/9MH+Bq4qhK09Kd8wlRU/V1h3yDEp00DdnFPwx4XhR3vDGro0u?=
 =?us-ascii?Q?3/9ZVpxoKNXG4c3PPuKip1ZNKgxy0CWhHkjFSzkL6QBGoOA27LcqvHW2k0IL?=
 =?us-ascii?Q?2s6bTE774t6ZD6jAV4gH6VtPYDETDaC4hdv/3/Rb2N07Iyp63gWOhYpjDCAC?=
 =?us-ascii?Q?HB64XUVwlyHAikfjqeB9DQ9reWMLiPlGkOUyQ4+jYBGKjYg0snshVGU12c/e?=
 =?us-ascii?Q?8sR9cT5DOzVbMj901G35W/21+JIxwf+w1HlEkeUu4IkEE8lTFk8FxXM7yfQc?=
 =?us-ascii?Q?N/J7pey9LzPe/UGUyRWYxjiN/AxcDzcx8JwndxZZ7y9mF0pfIo8LPmuFnRIH?=
 =?us-ascii?Q?BPXRWviPGMqkupJaw0fh7bmRS7BGFtopE7WjMzMQbGSR5DeDF0gnnpkQxG6I?=
 =?us-ascii?Q?tHfs6ZtYROmrPlOj8Qb3gFYOpIBwCo5dOojRp0Oc6Z+FTDOjFGg8v2A9DRhL?=
 =?us-ascii?Q?7PMb8rbGzjnTaNTlsZlye2IxeqcKMPWHEmEaH47taWpJQOlvzIzjg2uSobyg?=
 =?us-ascii?Q?bBL6ehZDvTBRU5R/3woBAWfDFpG1kRc3GxnZJ86kKIAZospFJuP2WCJReRX4?=
 =?us-ascii?Q?YXCCGS8J+j5rnpdh4S6tNmTWy6STs0YRtS+LfMd9/4VCOjzngngxcI8QDikb?=
 =?us-ascii?Q?yRLtbP9g0EK7FUijrrlbAk7hDf4+7d3pCGd2AMGU5pQ20DDWj361uKNeZVIu?=
 =?us-ascii?Q?WyCOU8y4tc5tES6tSqX1M/sMDUreQVf/UiRiwu6tLYzC9WgLEbol5Qi6rt4N?=
 =?us-ascii?Q?cauKB96LBMioeIbEeE9gGpA/y1OXAUc6Kx0JaSMTIgWj3Ci6+hzFVkoGemm1?=
 =?us-ascii?Q?EWlQf1UGXI60WSfVESMUxYgCZCN4r5kDAEO3bpavcUKK+0jw7qUzdSzN0EjC?=
 =?us-ascii?Q?aJ9bG1gaHSK6fSI5UYE5znGxRazlAYEfPDb5IIc6vk2i58M2lNVxVLs3PhQB?=
 =?us-ascii?Q?njEOjTjER0ZSQK4HEeVtyvpjgE8q6ZRsp3Op0SmeYcQm3aAr5gs+bskNe5wn?=
 =?us-ascii?Q?abKS/9f/sIff+jkIZvTlEjIP7ls3iMXCLU/tbYRuHOS1ec/ZgBccSPKPLRru?=
 =?us-ascii?Q?5vA0kNYLjjvOZzgnVq/d2yuZbPIKTVfEiWkWvSukG38V5ALskF9XdDKjM+mV?=
 =?us-ascii?Q?89Mgi8ZvcaUxOjMB5qYqL7YJicN3E57aK7S48c/LJfiQSp7BBz6mx58a8cz9?=
 =?us-ascii?Q?xAZp/OZVZWlmWcJamka2EzczZekaA6MowqNpnxU1/1lyONToPL2lU6x4lssh?=
 =?us-ascii?Q?CO4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1506.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73344fab-ffa1-48d0-f218-08d959d13de5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2021 18:29:06.5885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HH6GCbDG8yMD0A62eUnKrwQZ40rhQFq+qKt/x1cruAVjQLENORjRMn5By/W2esRwBQqeE88t5KcoBlok0cg/vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1224
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: Re: [Patch v5 0/3] Introduce a driver to support host accelerate=
d
> access to Microsoft Azure Blob for Azure VM
>=20
> On Thu, Aug 05, 2021 at 06:24:57PM +0000, Long Li wrote:
> > > Subject: Re: [Patch v5 0/3] Introduce a driver to support host
> > > accelerated access to Microsoft Azure Blob for Azure VM
> > >
> > > On 8/5/21 12:00 AM, longli@linuxonhyperv.com wrote:
> > > > From: Long Li <longli@microsoft.com>
> > > >
> > > > Azure Blob storage [1] is Microsoft's object storage solution for
> > > > the cloud. Users or client applications can access objects in Blob
> > > > storage via HTTP, from anywhere in the world. Objects in Blob
> > > > storage are accessible via the Azure Storage REST API, Azure
> > > > PowerShell, Azure CLI, or an Azure Storage client library. The
> > > > Blob storage interface is not designed to be a POSIX compliant
> interface.
> > > >
> > > > Problem: When a client accesses Blob storage via HTTP, it must go
> > > > through the Blob storage boundary of Azure and get to the storage
> > > > server through multiple servers. This is also true for an Azure VM.
> > > >
> > > > Solution: For an Azure VM, the Blob storage access can be
> > > > accelerated by having Azure host execute the Blob storage requests
> > > > to the backend storage server directly.
> > > >
> > > > This driver implements a VSC (Virtual Service Client) for
> > > > accelerating Blob storage access for an Azure VM by communicating
> > > > with a VSP (Virtual Service
> > > > Provider) on the Azure host. Instead of using HTTP to access the
> > > > Blob storage, an Azure VM passes the Blob storage request to the
> > > > VSP on the Azure host. The Azure host uses its native network to
> > > > perform Blob storage requests to the backend server directly.
> > > >
> > > > This driver doesn't implement Blob storage APIs. It acts as a fast
> > > > channel to pass user-mode Blob storage requests to the Azure host.
> > > > The user-mode program using this driver implements Blob storage
> > > > APIs and packages the Blob storage request as structured data to
> > > > VSC. The request data is modeled as three user provided buffers
> > > > (request, response and data buffers), that are patterned on the
> > > > HTTP model used by existing Azure Blob clients. The VSC passes
> > > > those buffers to VSP for Blob
> > > storage requests.
> > > >
> > > > The driver optimizes Blob storage access for an Azure VM in two way=
s:
> > > >
> > > > 1. The Blob storage requests are performed by the Azure host to
> > > > the Azure Blob backend storage server directly.
> > > >
> > > > 2. It allows the Azure host to use transport technologies (e.g.
> > > > RDMA) available to the Azure host but not available to the VM, to
> > > > reach to Azure Blob backend servers.
> > > >
> > > > Test results using this driver for an Azure VM:
> > > > 100 Blob clients running on an Azure VM, each reading 100GB Block
> Blobs.
> > > > (10 TB total read data)
> > > > With REST API over HTTP: 94.4 mins Using this driver: 72.5 mins
> > > > Performance (measured in throughput) gain: 30%.
> > > >
> > > > [1]
> > > >
> > >
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fdo
> > > cs
> > > > .microsoft.com%2Fen-us%2Fazure%2Fstorage%2Fblobs%2Fstorage-
> blobs-
> > > intro
> > > >
> > >
> duction&amp;data=3D04%7C01%7Clongli%40microsoft.com%7C6ba60a78f4e74
> > > aeb0b
> > > >
> > >
> b108d95833bf53%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C6376
> > > 378015
> > > >
> > >
> 92577579%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
> > > V2luMzIiL
> > > >
> > >
> CJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3Dab5Zl2cQdmUhdT3l
> > > SotDwMl
> > > > DQuE0JaY%2B1REPQ0%2FjXa4%3D&amp;reserved=3D0
> > >
> > > Is the ioctl interface the only user space interface provided by
> > > this kernel driver? If so, why has this code been implemented as a
> > > kernel driver instead of e.g. a user space library that uses vfio to
> > > interact with a PCIe device? As an example, Qemu supports many
> different virtio device types.
> >
> > The Hyper-V presents one such device for the whole VM. This device is
> > used by all processes on the VM. (The test benchmark used 100
> > processes)
> >
> > Hyper-V doesn't support creating one device for each process. We cannot
> use VFIO in this model.
>=20
> I still think this "model" is totally broken and wrong overall.  Again, y=
ou are
> creating a custom "block" layer with a character device, forcing all user=
space
> programs to use a custom library (where is it at?) just to get their data=
.

The Azure Blob library (with source code) is available in the following lan=
guages:
Java: https://github.com/Azure/azure-sdk-for-java/tree/main/sdk/storage/azu=
re-storage-blob
JavaScript: https://github.com/Azure/azure-sdk-for-js/tree/main/sdk/storage=
/storage-blob
Python: https://github.com/Azure/azure-sdk-for-python/tree/main/sdk/storage=
/azure-storage-blob
Go: https://github.com/Azure/azure-storage-blob-go
.NET: https://github.com/Azure/azure-sdk-for-net/tree/main/sdk/storage/Azur=
e.Storage.Blobs
PHP: https://github.com/Azure/azure-storage-php/tree/master/azure-storage-b=
lob
Ruby: https://github.com/azure/azure-storage-ruby/tree/master/blob
C++: https://github.com/Azure/azure-sdk-for-cpp/tree/main/sdk/storage#azure=
-storage-client-library-for-c

>=20
> There's a reason the POSIX model is there, why are you all ignoring it?

The Azure Blob APIs are not designed to be POSIX compatible. This driver is=
 used
to accelerate Blob access for a Blob client running in an Azure VM. It does=
n't attempt
to modify the Blob APIs. Changing the Blob APIs will break the existing Blo=
b clients.

Thanks,
Long
