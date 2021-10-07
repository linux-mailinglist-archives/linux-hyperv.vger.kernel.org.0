Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17017425A7A
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Oct 2021 20:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbhJGSR1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 7 Oct 2021 14:17:27 -0400
Received: from mail-bn8nam12on2127.outbound.protection.outlook.com ([40.107.237.127]:28193
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233807AbhJGSR1 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 Oct 2021 14:17:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sdn29w6flGsebAorczW22qhaw8NLq8Iain790pU8PCarPaVnOjcZY9Qh5HW0qJxcyXKncAQQuQSNrDyRd01nY+jwIV3U7Ewc3bd47SBE24qGF7KLj7GliRT+jfWo5T5QU8qBIesFB2SW61I3Tb7Igzms1KUHVMOaQYBx4o3zStKPRlMy63aF1kLha/XFNlY20KE52q7RCSrFyb3XM5LLEbYb4CiqxACMOga50rc/pdTBRSDpiiLCMYgjyDST1r41DOttD6oxCxC2zpTMTJD32h6/7gGk87tX2U+RBQNCdaXWfeHmZvVJ8iyr/kr/BazN6ks5s0HNFMESw75+Cxvizg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ec7zP9veX+E5R9Ndfeufn0nxdmPZ8znGwn7+N88fdUI=;
 b=Pi9W2kVOqndvZtOpxv/csml3gIFb1uTYnk8duGhgoLUC3MFT/3LTbly0zOA0UDCnZ+Rd8BN42RrWYwQbXIIpMf2Ow6R/Z3sH1yYc/16rNC8UrdbzcTBCMNN+spogFIEFtfNNw0JyChPLUlZNB0AUuQHWWwbexpZhw423Fbb9kZLnd0UxxypBpgOw3RP3A7339cJT9pDnS/YqglAZ5H4p7X7wgo6z6/ca1z0keWhqgJT+0GW+NVeU2T21MnetuH56cAeQfyHhW4NxIEcdPnS9LCmS8u+UWdrhm22cCymZueXwAOvIgzYFn2FSvYTBS0ckxhTwHqYJ9a+FfXqkU7gyUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ec7zP9veX+E5R9Ndfeufn0nxdmPZ8znGwn7+N88fdUI=;
 b=CtN18em18WC6Yx6wW26VBrYNixu2qdH83b93COeq1j0reTT/UAMFah98+TBhjyWQqfUPtqO3ceL+Z/sL8ZSxqM/7/+mzoPjd9yeSbVnOt8akf3YtNjgQ0jc9USH4leWQpwXpRuXauW9YYMU2le12UtZC6qXsqjEdlr2k4MyeaBc=
Received: from BY5PR21MB1506.namprd21.prod.outlook.com (2603:10b6:a03:23d::12)
 by SJ0PR21MB1981.namprd21.prod.outlook.com (2603:10b6:a03:298::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.4; Thu, 7 Oct
 2021 18:15:26 +0000
Received: from BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::c5e9:9018:e64f:c330]) by BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::c5e9:9018:e64f:c330%9]) with mapi id 15.20.4608.005; Thu, 7 Oct 2021
 18:15:26 +0000
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
Thread-Index: AQHXiceSNIn8c8rqq0aMs/Uc2xnVEKtlJaUAgAARXqCAAAZzgIADIFJggAC3SwCAAv3hYIBE4/SggAyEiKCAAJ8QAIAKHh2w
Date:   Thu, 7 Oct 2021 18:15:25 +0000
Message-ID: <BY5PR21MB15060E0A4AC1F6335A08EAB4CEB19@BY5PR21MB1506.namprd21.prod.outlook.com>
References: <1628146812-29798-1-git-send-email-longli@linuxonhyperv.com>
 <e249d88b-6ca2-623f-6f6e-9547e2b36f1f@acm.org>
 <BY5PR21MB15060F1B9CDB078189B76404CEF29@BY5PR21MB1506.namprd21.prod.outlook.com>
 <YQwvL2N6JpzI+hc8@kroah.com>
 <BY5PR21MB1506A93E865A8D6972DD0AAECEF49@BY5PR21MB1506.namprd21.prod.outlook.com>
 <YQ9oTBSRyHCffC2k@kroah.com>
 <BY5PR21MB15065658FA902CC0BC162956CEF79@BY5PR21MB1506.namprd21.prod.outlook.com>
 <BY5PR21MB1506091AFED0EB62F081313ECEA29@BY5PR21MB1506.namprd21.prod.outlook.com>
 <DM6PR21MB15135923A4CB0E61786ABC22CEAA9@DM6PR21MB1513.namprd21.prod.outlook.com>
 <YVa6dtvt/BaajmmK@kroah.com>
In-Reply-To: <YVa6dtvt/BaajmmK@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=49de1b74-ade8-40c8-bab7-98a7668ac908;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-10-07T18:06:44Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7f28d15-c684-4f15-b35b-08d989be6fbd
x-ms-traffictypediagnostic: SJ0PR21MB1981:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <SJ0PR21MB19813DF03608528B6B241F63CEB19@SJ0PR21MB1981.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OQTmMCD/lV/uAWnN923s7WIqEzgvJ7/O6lZE6Ri4+St77rs/kaU4TF44FpQhr3ET52v24wsaGAxlXDQ4/hRUMGC2Z5NXQrCWglTIR+EU70GM3Xx6Na6nR2QXXY2SwUR+sim0D/EhIkVwvwkpDsZYCu2Uv64zgcM+FQGqyOOxG5Q6rrtQa0m9o85IyfKPuy5yOdyZoFH3jn4YW0rRGHjNVW3YBIPys6GCpmX7QOw08e8HTorD5x+JAPwXrfyP3Mj7Un6T691sbOJQdZRPM3QRRWzSZp1yGUxYt4IMrZKWYa7ThHZlGxs9iHkQKBfbQNeKaBkGYqwXdkkJ3BV7sYkG0YSytcQQ4V0ti/JwOajK+qnZXxB/hvoaOBGY4xFUPDEKQHK5nm85vYZmbP84RB5wF/XOsRMxrKm0T0MwLliQ7+FqAjCB09tmgcdLwdJSO4+6SoC54lCcr12L98orZFixQW6uS1LjoobWraQH3GSVeC4QbYl0MCkMkf1ABRf5v74SHS7L+kx9L54XrYXGjBKeARp1eelkE853yqZmNORX0fladC/iLraLV3wmzr1W/7dX9FQLL8asu30joDBRG2dsZecGaf66pOyTPLBuXEzYwskCX+7Kfcp9djonwRCEqoDpjK4q7K9GX4NQwDC0QZ5Q7h7A25ZKWDvWK5S0TPvMEE/033E4ZpSmwvdZoh+gmWUv62qs6CcwSvTg3oPIzaoFeFjH5m1kFL3B+PdlUU6KQFcJQ9pTqwStEIxn76u6jo5uBjeO5vupyNyXLRfLGvADoZRNlyP20JLTDHqDdo1Me0o68MianjyHhTWD9cYA3ClEnxkzVEuwD9dEc+WNqH/o9w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1506.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(47530400004)(508600001)(8676002)(8936002)(10290500003)(8990500004)(316002)(86362001)(66446008)(64756008)(52536014)(9686003)(55016002)(66556008)(5660300002)(54906003)(966005)(2906002)(66946007)(66476007)(76116006)(7416002)(83380400001)(71200400001)(38070700005)(6506007)(26005)(38100700002)(186003)(33656002)(7696005)(82960400001)(82950400001)(6916009)(4326008)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3RgNxZmjHC04HBhn12Fm2GVJiDMGX3PhGhspk5oRffZ/YyAQq5jFM6apYbWp?=
 =?us-ascii?Q?ZsQklnZDSRS3JEjhfzbvSdamBHeKvcAfudF9tVy5Q07kxS4YaHErE8NLKN+X?=
 =?us-ascii?Q?W0Gwj+wYdqoukNDtPzNO2Yq0ZsooVh8XZy65OeB9hkW/SNzS9Zk9fJMQr1hT?=
 =?us-ascii?Q?VD9f3uO90qJcp1NO4yx6VZR1Ub+r5oaIp2e+NhE6fcWI4B6MvZjr6y88d/Lw?=
 =?us-ascii?Q?bsYTJl0uAeR1BqtMdhiRgyMsw3FYkicMem20ykMrzbS/nccjn2+8xdqwBJv6?=
 =?us-ascii?Q?br8mStBKsfc/c3O2jhLwgVXqT+mOIkAbU/Jx7+Wm+rFNh5JXE+aJ+gnqsJYW?=
 =?us-ascii?Q?2N/4c4bBtgKKBXAsayqFMyNx0ZBMOFdtc8gzAKYYYQDPUFrCVWmd5sYGFDpt?=
 =?us-ascii?Q?p6suGkJgyNs58b5WEQxeaG+C3z2l0GUdN1wq1P2TavfpBi6Gg6m85an4vSl3?=
 =?us-ascii?Q?/2vD3GdjxQn+GFDND0vacTumgMe90KHljKd4VuFXcfWP6cNq/Rcu8O7d7cTR?=
 =?us-ascii?Q?9QA+BgX705PzCB2P7BdY3FFe/HstSwpafZBTO2W2+9eR+jrnHBpetV7yJQ6E?=
 =?us-ascii?Q?Q8ceCdraH+h8L7Dc6jjZF0b/9Y50uJeGyPB+HGgyoA+pazf6OLMv3ntg9zT/?=
 =?us-ascii?Q?TRE++xRaKhxYRJybwEOH1eQQuIY2FCE2w2QNFbqEN4ogroIZwXkPCHr1WOTU?=
 =?us-ascii?Q?geYTns7T5q7ZHiG3+O8U+jtyNuqrspdCFycLqmcTBwmBbemlOtYCmbl8njIO?=
 =?us-ascii?Q?UqqYbaN1GbBxwSThWeZXDcf4P4igj6UMJ5qIn8UxOpdaGKQrnvU2UqfW7Y8M?=
 =?us-ascii?Q?+LdMKWgI4fMeRjdwB33DCeO/phUHN1xLkX6nagKip/y4VBcxY5iOGwUuaPOu?=
 =?us-ascii?Q?wxa8OUl/KO4CpsXNcXVR3GJpIOjAY+jeaU+sNcVDEZgHRpauxmunj7WGTVtG?=
 =?us-ascii?Q?vWx3ye2l5OunrMwKGYW2ksJgcqm12FhEesbBuUAco8LBAV8hyzMTPiwSeIpF?=
 =?us-ascii?Q?6x9egD/htXrkBaNaN5ImLSM6lBXtkSS7+dJIebadIViXG4VAl3m8k58IE06b?=
 =?us-ascii?Q?fU6tnw3BMNFJddbqUHlVAQnnJGx/ANodOuvJ3sbz22pdNvqHhfh/BHNYLISm?=
 =?us-ascii?Q?CDibA70DfZ8JF36D5km5NWF5Dnbld+SIP+k2nye++Ke1z0fxAepawovFnTil?=
 =?us-ascii?Q?NhZMr98bBJk4WHxGV3Gp/D1sshzoqD05L09jCACTIeSfAnVI6d0jiup5OLyT?=
 =?us-ascii?Q?J2LaBmxCk4ubI0TPvt+vqhZJ7zpFB6sMD5faNGewB/DnNbNBZWw4jnMrbiD7?=
 =?us-ascii?Q?XAj1MRi512NHlrGjrAXgJ5/k?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1506.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7f28d15-c684-4f15-b35b-08d989be6fbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2021 18:15:25.9676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T5oLuUkghV8uZyJESPDFwQAuohswRxnUoA538JYyiux5RahygGR2igErHBra6OafBjceCENC5ij7wnJTARcpGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB1981
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: Re: [Patch v5 0/3] Introduce a driver to support host accelerate=
d
> access to Microsoft Azure Blob for Azure VM
>=20
> On Thu, Sep 30, 2021 at 10:25:12PM +0000, Long Li wrote:
> > > Greg,
> > >
> > > I apologize for the delay. I have attached the Java transport
> > > library (a tgz file) in the email. The file is released for review un=
der "The
> MIT License (MIT)".
> > >
> > > The transport library implemented functions needed for reading from
> > > a Block Blob using this driver. The function for transporting I/O is
> > > Java_com_azure_storage_fastpath_driver_FastpathDriver_read(),
> > > defined in "./src/fastpath/jni/fpjar_endpoint.cpp".
> > >
> > > In particular, requestParams is in JSON format (REST) that is passed
> > > from a Blob application using Blob API for reading from a Block Blob.
> > >
> > > For an example of how a Blob application using the transport
> > > library, please see Blob support for Hadoop ABFS:
> > >
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgi
> > > th
> > >
> ub.com%2Fapache%2Fhadoop%2Fpull%2F3309%2Fcommits%2Fbe7d12662e2
> > >
> 3a13e6cf10cf1fa5e7eb109738e7d&amp;data=3D04%7C01%7Clongli%40microsof
> > >
> t.com%7C3acb68c5fd6144a1857908d97e247376%7C72f988bf86f141af91ab2d7
> > >
> cd011db47%7C1%7C0%7C637679518802561720%7CUnknown%7CTWFpbGZsb
> > >
> 3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> > > %3D%7C1000&amp;sdata=3D6z3ZXPtMC5OvF%2FgrtbcRdFlqzzR1xJNRxE2v2
> Qrx
> > > FL8%3D&amp;reserved=3D0
>=20
> Odd url :(
>=20
> > > In ABFS, the entry point for using Blob I/O is at AbfsRestOperation
> > > executeRead() in hadoop-tools/hadoop-
> > >
> azure/src/main/java/org/apache/hadoop/fs/azurebfs/services/AbfsInput
> > > Str eam.java, from line 553 to 564, this function eventually calls
> > > into
> > > executeFastpathRead() in hadoop-tools/hadoop-
> > > azure/src/main/java/org/apache/hadoop/fs/azurebfs/services/AbfsClien
> > > t.ja
> > > va.
> > >
> > > ReadRequestParameters is the data that is passed to requestParams
> > > (described above) in the transport library. In this Blob application
> > > use-case, ReadRequestParameters has eTag and sessionInfo
> > > (sessionToken). They are both defined in this commit, and are
> > > treated as strings passed in JSON format to I/O issuing function
> > > Java_com_azure_storage_fastpath_driver_FastpathDriver_read() in the
> > > transport library using this driver.
> > >
> > > Thanks,
> > > Long
> >
> > Hello Greg,
> >
> > I have shared the source code of the Blob client using this driver, and=
 the
> reason why the Azure Blob driver is not implemented through POSIX with fi=
le
> system and Block layer.
>=20
> Please wrap your text lines...
>=20
> Anyway, no, you showed a client for this interface, but you did not expla=
in
> why this could not be implemented using a filesystem and block layer.  On=
ly
> that it is not what you did.
>=20
> > Blob APIs are specified in this doc:
> >
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fdocs
> > .microsoft.com%2Fen-us%2Frest%2Fapi%2Fstorageservices%2Fblob-
> service-r
> > est-
> api&amp;data=3D04%7C01%7Clongli%40microsoft.com%7C6a51f21c78a3413e63
> >
> 9d08d984ae2c58%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C6376
> 867059
> >
> 24012728%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
> V2luMzIiL
> >
> CJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DZiWmZ%2FpuQHNn
> dHNmnIWHO
> > yrXPSscNBbR6RvSr%2FCBuEY%3D&amp;reserved=3D0
> >
> > The semantic of reading data from Blob is specified in this doc:
> >
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fdocs
> > .microsoft.com%2Fen-us%2Frest%2Fapi%2Fstorageservices%2Fget-
> blob&amp;d
> >
> ata=3D04%7C01%7Clongli%40microsoft.com%7C6a51f21c78a3413e639d08d984a
> e2c5
> >
> 8%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C63768670592401272
> 8%7CUn
> >
> known%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6
> Ik1haW
> >
> wiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DxqUObAdYkFf8efSRuK%2FOXm%2
> BRd%2FCiBI
> > 0BjNfx9YpkGN0%3D&amp;reserved=3D0
> >
> > The source code I shared demonstrated how a Blob is read to Hadoop
> through ABFS. In general, A Blob client can use any optional request head=
ers
> specified in the API suitable for its specific application. The Azure Blo=
b service
> is not designed to be POSIX compliant. I hope this answers your question =
on
> why this driver is not implemented at file system or block layer.
>=20
>=20
> Again, you are saying "it is this way because we created it this way", wh=
ich
> does not answer the question of "why were you required to do it this way"=
,
> right?
>=20
> > Do you have more comments on this driver?
>=20
> Again, please answer _why_ you are going around the block layer and
> creating a new api that circumvents all of the interfaces and protections=
 that
> the normal file system layer provides.  What is lacking in the existing a=
pis that
> has required you to create a new one that is incompatible with everything
> that has ever existed so far?
>=20
> thanks,
>=20
> greg k-h

Hello Greg,

Azure Blob is massively scalable and secure object storage designed for clo=
ud native=20
workloads. Many of its features are not possible to implement through POSIX=
 file=20
system. Please find some of them below:
=20
For read and write API calls (for both data and metadata) Conditional Suppo=
rt=20
(https://docs.microsoft.com/en-us/rest/api/storageservices/specifying-condi=
tional-headers-for-blob-service-operations)=20
is supported by Azure Blob. Every change will result in an update to the La=
st Modified=20
Time (=3D=3D ETag) of the changed file and customers can use If-Modified-Si=
nce, If-Unmodified-Since,=20
If-Match, and If-None-Match conditions. Furthermore, almost all APIs suppor=
t this=20
since customers require fine-grained and complete control via these conditi=
ons. It=20
is not possible/practical to implement Conditional Support in POSIX filesys=
tem.
=20
The Blob API supports multiple write-modes of files with three different bl=
ob types:=20
Block Blobs (https://docs.microsoft.com/en-us/rest/api/storageservices/oper=
ations-on-block-blobs),=20
Append Blobs, and Page Blobs. Block Blobs support very large file sizes (hu=
ndreds=20
of TBs in a single file) and are more optimal for larger blocks, have two-p=
hased=20
commit protocol, block sharing, and application control over block identifi=
ers. Block=20
blobs support both uncommitted and committed data. Block blobs allow the us=
er to=20
stage a series of modifications, then atomically update the block list to i=
ncorporate=20
multiple disjoint updates in one operation. This is not possible in POSIX f=
ilesystem.
=20
Azure Blob supports Blob Tiers (https://docs.microsoft.com/en-us/azure/stor=
age/blobs/access-tiers-overview).=20
The "Archive" tier is not possible to implement in POSIX file system. To ac=
cess data=20
from an "Archive" tier, it needs to go through rehydration (https://docs.mi=
crosoft.com/en-us/azure/storage/blobs/archive-rehydrate-overview)=20
to become "Cool" or "Hot" tier. Note that the customer requirement for tier=
s is that=20
they do not change what URI, endpoint, or file/folder they access at all - =
same endpoint,=20
same file path is a must requirement. There is no POSIX semantics to descri=
be Archive=20
and Rehydration, while maintaining the same path for the data.
=20
The Azure Blob feature Customer Provided Keys (https://docs.microsoft.com/e=
n-us/azure/storage/blobs/encryption-customer-provided-keys)=20
provides different encryption key for data at a per-request level. It's not=
 possible=20
to inject this into POSIX filesystem and it is a critical security feature =
for customers=20
requiring higher level of security such as the Finance industry customers. =
There=20
exists file-level metadata implementation that indicates info about the enc=
ryption=20
as well. Note that encryption at file/folder level or higher granularity do=
es not=20
meet such customers' needs - not just on individual customer requirements b=
ut also=20
related financial regulations.
=20
The Immutable Storage (https://docs.microsoft.com/en-us/azure/storage/blobs=
/immutable-storage-overview)=20
feature is not possible with POSIX filesystem. This provides WORM (Write-On=
ce Read-Many)=20
guarantees on data where it is impossible (regardless of access control, i.=
e. even=20
the highest level administrator/root) to modify/delete data until a certain=
 interval=20
has passed; it also includes features such as Legal Hold. Note that per the=
 industry=20
and security requirements, the store must enforce these WORM and Legal Hold=
 aspects=20
directly, it cannot be done with access control mechanisms or enforcing thi=
s at the=20
various endpoints that access the data.
 =20
Blob Index (https://docs.microsoft.com/en-us/azure/storage/blobs/storage-ma=
nage-find-blobs)=20
which provides multi-dimensions secondary indexing on user-settable blob ta=
gs (metadata)=20
is not possible to accomplish in POSIX filesystem. The indexing engine need=
s to incorporate=20
with Storage access control integration, Lifecycle retention integration, r=
untime=20
API call conditions, it's not possible to support in the filesystem itself;=
 in other=20
words, it cannot be done as a side-car or higher level service without comp=
romising=20
on the customer requirements for Blob Index. Related Blob APIs for this are=
 Set Blob=20
Tags (https://docs.microsoft.com/en-us/rest/api/storageservices/set-blob-ta=
gs) and=20
Find Blob by Tags (https://docs.microsoft.com/en-us/rest/api/storageservice=
s/find-blobs-by-tags).

Thanks,

Long

