Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A363D01C8
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jul 2021 20:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhGTR5F (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Jul 2021 13:57:05 -0400
Received: from mail-mw2nam10on2126.outbound.protection.outlook.com ([40.107.94.126]:45248
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229650AbhGTR5C (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Jul 2021 13:57:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UjRJRmaFuMNv4GxfoA1OYPJwg+DCGlCO5O/CEASANc/O9u+KGWquPLUK+cU9iGkfMkU4UR+RXLrqtwJHu79/vyRNqh3trzIKIAY54x2FiKmyF9spL75UzlfTjFTAuCUJqxYmWLjmo3EJn7h9sX90qZBDIlqUhzc1/t4bnSBIT0PbdKAqySErV/gaq48HPcA+SaELK80BvOi+yE+xexeTcehZJd705rK33UIRCsrDTeGfwk2Qb0jCe95iu6ZfmgT44urv+Fo+pPlO3+5Z13b/lQceWI61I/AbAYjvsrDIwD5NUECEXgYmvyYjL2MkW/imzvy1Q6llAn+f0XZxGo0jmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5EfQfiSw4IuT60y4WfekfTj1rSwD1Z+U+5oAaQJRdfM=;
 b=cJfPMT0Y5NHomymZvTbg+AgxA9t3Ml0/8FgTKSvZrf2ZV/rUF0w4RfewnRMbsZR8tQUE3nrTjypzMbRYvQsdOnUwiEUEUPf9WD3FKRvOCl7Kjes3k4lz6RXJukUp2QciHNBMNNsVzK4sqADQaRSzhVM7T6WQvdGctMYfW5nGe/qMKhLOCoxU69xuxLGab/LXCAJS0JEgim/q0+ki29nuGBrRJuYwv2nZ+7NWzaoRS97OTnvJneHnTeptw4IRpG6dGct4VeKAojYKKQkM9UgzDokGtafYOAEL5DZtDl+igYu6vkj/awPHnEjLF3K3mnfjhH6PK5uFX2ZF0xEKN9FVxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5EfQfiSw4IuT60y4WfekfTj1rSwD1Z+U+5oAaQJRdfM=;
 b=WmIcJ2HtGvm2+2gB8zaaX5QaKSV6TqFmdwL4fe1AjPJKqR3wE8OOr59RupAyCZ7PyAr0v3Ngk0mh5zMKimEc17prh27MIk235XeWcmgESHZgv8VG51GrMTsX/X3NJVJ+F4NmG7ZFYfRmg7hBzg/+tkHE+neBy9HMc7wo9wHGgLY=
Received: from BY5PR21MB1506.namprd21.prod.outlook.com (2603:10b6:a03:23d::12)
 by SJ0PR21MB1295.namprd21.prod.outlook.com (2603:10b6:a03:3fa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.4; Tue, 20 Jul
 2021 18:37:38 +0000
Received: from BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::d97f:36c9:1b1:5d07]) by BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::d97f:36c9:1b1:5d07%8]) with mapi id 15.20.4373.006; Tue, 20 Jul 2021
 18:37:38 +0000
From:   Long Li <longli@microsoft.com>
To:     Greg KH <greg@kroah.com>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>
CC:     "linux-fs@vger.kernel.org" <linux-fs@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [Patch v4 0/3] Introduce a driver to support host accelerated
 access to Microsoft Azure Blob
Thread-Topic: [Patch v4 0/3] Introduce a driver to support host accelerated
 access to Microsoft Azure Blob
Thread-Index: AQHXfRe50VdmS4suz0yD44Lpyf2vv6tMBNWAgAAcpwA=
Date:   Tue, 20 Jul 2021 18:37:38 +0000
Message-ID: <BY5PR21MB1506D5D10F15E291BB553B50CEE29@BY5PR21MB1506.namprd21.prod.outlook.com>
References: <1626751866-15765-1-git-send-email-longli@linuxonhyperv.com>
 <YPbxr8XbK0IbD02r@kroah.com>
In-Reply-To: <YPbxr8XbK0IbD02r@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=85a33709-db94-4d49-93a0-6e8c7518f314;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-07-20T17:36:56Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9613ee40-273d-48db-a88e-08d94bad731c
x-ms-traffictypediagnostic: SJ0PR21MB1295:
x-microsoft-antispam-prvs: <SJ0PR21MB1295B649FC34DFB798623982CEE29@SJ0PR21MB1295.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rtgGPs0vkOqb6BZnZGHTkQEGJPLJmbpj75OIuO7GPlBEr7HWAr5NCFvMbM6EXcQ8+R+qZZ0OK9vtV8FWEazS/zUOWykjsxPL2GV5p7k+N93gHT1zJVxaHEUEAPvh9t+lZ2qjMlv3WffpPYWqrj8jrLyMMWjmfS8yQYndJ32jP23CNFbTkqwu5X/PZ5aJ/OrksEed/e3yQBpgKcbqQmStQeLN/zLjv6HM8M23uh2WrhS54Py4kuz7fRanW4f/tHWzcBCsr2tkRoIYQnRl/dQj11U0OKZytckvrTDhu3Go2BpmXG5NqEXDNKPXyaSxmlHD/Bzmjz1g8lE8k00tpuwImOob2xI4QlxU1+L4qofRBC3JFXenYl5U7NP3weQoi7t4+ll/xnBREpiyABp+33vWB5uYRmAa/MgBsIlp4jtbGocwhD4BtX3JMiy0kK1+uf5+4bH4cMT5y/RvgPIJdeA7rs7/pE1G1fP1xfnRXn1OZZwrV4vVdPutNWgKgYTMqLmK+kBeSxSONrYRClQC+xjSEzO9pFLgHYiXwjyI/ufGZLr+fIrEVnZ3VWhpVZVJGshYXdELBoFpqaI52hmyJYwhDu/5S/yiEzWwwo9UAor8Uwqdq2yJ0ruSz6J7YKIBvuKxMr0AI9MS40WoExX3nsdOQgREs0M1qaq4mQ9m/trDPnTOdofg/5m2icUHdAcu8g+YzoSTy/YDMika2a+9xIjIb1pWmiD197n5WF24ydULkODozbC3jH0ZGH+Mx+YTOUgterMesY64goPZd8Q66XoR7mJFWmaMYFgw8tds3yDXPOpkfUvL+B235c4SZDhb8NXkuyto5HbHyEnUw13KN2GWvA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1506.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(47530400004)(82950400001)(8676002)(9686003)(6506007)(54906003)(966005)(508600001)(110136005)(38100700002)(316002)(55016002)(64756008)(26005)(8990500004)(33656002)(4326008)(5660300002)(76116006)(86362001)(71200400001)(122000001)(83380400001)(10290500003)(186003)(8936002)(52536014)(2906002)(66946007)(7696005)(82960400001)(66476007)(66556008)(66446008)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jmUGEtokJ7Z8oHdy6iOLEMW+6GQtHC0giMVAtTEkjx3LohIGH+GLXT36kH4x?=
 =?us-ascii?Q?UQkbKqpNQc1HOs7VOl+ENRAJbnJ7TpBVBOlQdQuE5nvytLlFhnW2AYSWq5Sa?=
 =?us-ascii?Q?rzemiHcvgNOmo88A20WZYmsursIKZ9y23iZtnK619lR/Imse/4Mfszuh7dU3?=
 =?us-ascii?Q?JgOBy00fKnsAIq6e1jxFlp4XRyO6Qlq9o/jgFuzRnTazvjOSm0SeHVwB0oRU?=
 =?us-ascii?Q?FbBxEvJPPFa4OnU8KhuLgOQE8PXo3EMQ0tNh+Uw6Twy1f60hXfChalUh5CtZ?=
 =?us-ascii?Q?0BPG/IoWPYvjkoUxt671YAQ9aGg0uRQqIcaNO5A4iOSG3MGpriV8S/MgIig0?=
 =?us-ascii?Q?eF9nxWj4V+iHiVIuRvlnHqMkxGYFBZCsLzcXUyJeY3/kYkKeevlZwK/59Tdq?=
 =?us-ascii?Q?Goh3iV47R/XDyoKVPgUnsOmqnl118exxcv7OG9MFyO/LttMuRZJXvl23YqZI?=
 =?us-ascii?Q?y/9dab5jbaR/do41B95Cs47AvW174Ar1A/2iryy/83E7Z5uHmpO4MSOMOft1?=
 =?us-ascii?Q?vtbzY7IUELakr0f5Qd1+lFTvk/sAAKL50Vw5ld7Y/HqFsC4HYXIiUWfOeTSO?=
 =?us-ascii?Q?aqR72K2Pk3R9E29mExHPC6Q12q4jBsGmNrBoT28q3vNid2htEwcm69bp7OqJ?=
 =?us-ascii?Q?HBw556A+5+YabxvXJ0GVrdwOMM2Ez3fpMxuUbuzFKDUqP/v2LCzUHZ90bNFx?=
 =?us-ascii?Q?kt4lCg1GBXtHz0fY61usxo8n9522+trOoP/+wO0im0rLLzwLvPGsHJVTEBt9?=
 =?us-ascii?Q?U7+htKBpfokAvkeoELkbIcXrG8gYHjbqmtbs5LCmdb7jkBZIAWgAZZkdIr2a?=
 =?us-ascii?Q?5ruYolAU92cjzXX1WcMTS8Mv6AbxalkBswaMX3px6ogthDrazCGeE1uThXL7?=
 =?us-ascii?Q?WgXA5mx7wnDU2H3CCo2kTK0IvpkpxVcwTGGynBy6c3Bf3ZyCrK762YMf2pM5?=
 =?us-ascii?Q?Tm3TbmFPUapOxDpuVdU6unFBPUbXQhLYwFzXlCpyn7tLc0ezf5VQbSRy7m41?=
 =?us-ascii?Q?FDyS0WIzACUJfyi6Qh0O3UMSv+uAarjpVvWKFGapYg/h/8qokYhQcq2UvnFH?=
 =?us-ascii?Q?xMwdi9BmRhs2eSP7mbCrSzm+tpsjndMEEZn08m8UPiEwUptIEJtaLHiPCnwK?=
 =?us-ascii?Q?Rh+5A9HntXI2WSH/CRsho4gkxkpB0CdefWgip4jadELZahZUFR/yAQAwPvdE?=
 =?us-ascii?Q?673JJwYypM5VHAW5dcBJ2pLLblwe+tRTtIVJr4zBt0q8fm+TZkliDhbQDei5?=
 =?us-ascii?Q?KpG9TkYbIeSdZJuDKbWgyb78Ye/qhO+HtPmF8te3SVnC9P5+kG7pmOOiQIEf?=
 =?us-ascii?Q?Lh4=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1506.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9613ee40-273d-48db-a88e-08d94bad731c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2021 18:37:38.1114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EYjCCl9CJ17AqxJxypxZMn3mwglyeinRXu6OjPriDsp6JFIfEbtnhz7M67F8FvEyEXXK4Z/zWd1Sd5pQzw+ogw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB1295
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: Re: [Patch v4 0/3] Introduce a driver to support host accelerate=
d
> access to Microsoft Azure Blob
>=20
> On Mon, Jul 19, 2021 at 08:31:03PM -0700, longli@linuxonhyperv.com wrote:
> > From: Long Li <longli@microsoft.com>
> >
> > Microsoft Azure Blob storage service exposes a REST API to
> > applications for data access.
> >
> (https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fdoc
> > s.microsoft.com%2Fen-us%2Frest%2Fapi%2Fstorageservices%2Fblob-
> service-
> > rest-
> api&amp;data=3D04%7C01%7Clongli%40microsoft.com%7Ce499fbe161554232e
> >
> b1608d94b96a772%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637
> 623932
> >
> 843247787%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIj
> oiV2luMzIi
> >
> LCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&amp;sdata=3D9CKNHAmurdBWp
> ZeLfkiC18
> > CXNg66UhKsSZzzHZkzf0Y%3D&amp;reserved=3D0)
> >
> > This patchset implements a VSC (Virtualization Service Consumer) that
> > communicates with a VSP (Virtualization Service Provider) on the
> > Hyper-V host to execute Blob storage access via native network stack on
> the host.
> > This VSC doesn't implement the semantics of REST API. Those are
> > implemented in user-space. The VSC provides a fast data path to VSP.
> >
> > Answers to some previous questions discussing the driver:
> >
> > Q: Why this driver doesn't use the block layer
> >
> > A: The Azure Blob is based on a model of object oriented storage. The
> > storage object is not modeled in block sectors. While it's possible to
> > present the storage object as a block device (assuming it makes sense
> > to fake all the block device attributes), we lose the ability to
> > express functionality that are defined in the REST API.
>=20
> What "REST API"?
>=20
> Why doesn't object oriented storage map to a file handle to read from?
> No need to mess with "blocks", why would you care about them?
>=20
> And again, you loose all caching, this thing has got to be really slow, w=
hy add
> a slow storage interface?  What workload requires this type of slow block
> storage?

"Blob REST API" expresses storage request semantics through HTTP. In Blob
REST API, each request is associated with a context meta data expressed in
HTTP headers. The ability to express those semantics is rich, it's only lim=
ited
by HTTP protocol.

There are attempts to implement the Blob as a file system.
Here is an example filesystem (BlobFuse) implemented for Blob:
(https://github.com/Azure/azure-storage-fuse).

It's doable, but at the same time you lose all the performance and
shareable/security features presented in the REST API for Blob. A POSIX
interface cannot express same functionality as the REST API for Blob.

For example, The Blob API for read (Get Blob,=20
https://docs.microsoft.com/en-us/rest/api/storageservices/get-blob)
has rich meta data context that cannot easily be mapped to POSIX. The same
goes to other Blob API to manage security tokens and the life cycle of shar=
eable
objects.

BlobFuse (above) filesystem demonstrated why Blob should not be implemented
on a filesystem. It's useable for data management purposes. It's not usable=
 for an I/O
intensive workload. It's not usable for managing sharable objects and secur=
ity tokens.

Blob is designed not to use file system caching and block layer I/O schedul=
ing.
There are many solutions existing today, that access raw disk for I/O, bypa=
ssing
filesystem and block layer. For example, many database applications access =
raw
disks for I/O. When the application knows the I/O pattern and its intended =
behavior,
it doesn't get much benefit from filesystem or block.

>=20
> > Q: You also just abandoned the POSIX model and forced people to use a
> > random-custom-library just to access their storage devices, breaking
> > all existing programs in the world?
> >
> > A: The existing Blob applications access storage via HTTP (REST API).
> > They don't use POSIX interface. The interface for Azure Blob is not
> > designed on POSIX.
>=20
> I do not see a HTTP interface here, what does that have to do with the ke=
rnel?
>=20
> I see a single ioctl interface, that's all.

The driver doesn't attempt to implement Blob API or HTTP. It presents a fas=
t data
path to pass Blob requests to hosts, so the guest VM doesn't need to assemb=
le
a HTTP packet for each Blob REST requests. This also eliminates additional
overhead in guest network stack to send the HTTP packets over TCP/IP.

Once the request reaches the Azure host, it knows the best way to reach to =
the=20
backend storage and serving the Blob request, while at the same time all th=
e=20
security and integrity features are preserved.


>=20
> > Q: What programs today use this new API?
> >
> > A: Currently none is released. But per above, there are also none
> > using POSIX.
>=20
> Great, so no one uses this, so who is asking for and requiring this thing=
?
>=20
> What about just doing it all from userspace using FUSE?  Why does this HA=
VE
> to be a kernel driver?

We have a major workload nearing the end of development. Compared with
REST over HTTP, this device model presented faster data access and CPU savi=
ngs
in that there is no overhead of sending HTTP over network.

Eventually, all the existing Blob REST API applications can use this new AP=
I, once
it gets to their Blob transport libraries.

I have explained why BlobFuse is not suitable for production workloads. The=
re
are people using BlobFuse but mostly for management purposes.

Thanks,
Long

>=20
> thanks,
>=20
> greg k-h
