Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6201B1A4A82
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Apr 2020 21:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgDJTfy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 10 Apr 2020 15:35:54 -0400
Received: from mail-mw2nam12on2121.outbound.protection.outlook.com ([40.107.244.121]:47823
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726142AbgDJTfx (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 10 Apr 2020 15:35:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E/UUsBbHeqGO1GAMiN5VE62LpdgGj/vpBXxdsaRm8zlDx92ye26RqOm+mYINqt9dTY8mpxw7wbxNvqdJ48ofXlawaANlaLs8nIgShnyS1B76zutf1Ue8JRs5lQql0qb7OjBqUSbe8izchUBJ2NAZZVq3bFF7hcAwSlcY/S556XMOrI3EwL+E5FMSa/+blP3Vh3fWTC2QJqZBwX0bmaOiirShnnPfHhZkEkmCuNcpUw4EMngeX+mdHcJUyvsx7oQUCzWfwcENXEN0/1g+2NszMcTAv7P78z/3IeGNRrbd0FgdT7mXrGq/CC6A7qRtgGjcvMqySU2uoExyaNM4NF+9iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcn9vNaeyU6zFdtyZsqwv8vWgwM3zxafEf1e8UtzGJY=;
 b=Ij0uhM3QyjHc5LO9gwuJx5WEOfmq57ggDgOTAb7od/jRyL1UGC7PzcvLk6sZRXy/ufru2HHQSbsO32QkG+mm/jeKbbx0Y+TDmG4j9OF6RWt/iH5+G2yFrXzWtd8EOrq0amH6VtXdGf/Oy9psbBqXrjaRUj4PZGlz/4EZ0GBrYaY7N2eToQ99AOvSwcoAOud7SV/CN3Bzd3AGWJePl/N3KtqZMcJUL72ujuDM3y3hfST01zB2AnCEw+OXRyyrTqjUfO+fbVBoCxpMzyVemKVmyc/DvIVxKGlEFdVnjbra4PToVTQnpPZrza18w7ihF7SBV4pUm+qhD68k6cd3vLCDVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcn9vNaeyU6zFdtyZsqwv8vWgwM3zxafEf1e8UtzGJY=;
 b=NlnqH5H+951I30UgIUhuJa4OrFIfi4d60ntMckxRcn6MK0jZqeh1PfLfbGugXqpXqJ1WziM8vH8OuG1A92rFEdKfJ8hsAFqOik3L9SzUXBfiotwzGdVFLM24wZPoNX0AmVqCAdOb800a7y1ksaLnZZza5rWlOeB2WtF5Jg1EviQ=
Received: from DM5PR2101MB1047.namprd21.prod.outlook.com (2603:10b6:4:9e::16)
 by DM5PR2101MB1109.namprd21.prod.outlook.com (2603:10b6:4:a2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.12; Fri, 10 Apr
 2020 19:35:50 +0000
Received: from DM5PR2101MB1047.namprd21.prod.outlook.com
 ([fe80::f54c:68f0:35cd:d3a2]) by DM5PR2101MB1047.namprd21.prod.outlook.com
 ([fe80::f54c:68f0:35cd:d3a2%9]) with mapi id 15.20.2921.009; Fri, 10 Apr 2020
 19:35:50 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        vkuznets <vkuznets@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: RE: [PATCH 11/11] scsi: storvsc: Re-init stor_chns when a channel
 interrupt is re-assigned
Thread-Topic: [PATCH 11/11] scsi: storvsc: Re-init stor_chns when a channel
 interrupt is re-assigned
Thread-Index: AQHWC6i2r4sWCVTnUkGYWEk5nYA+/qhyxvZg
Date:   Fri, 10 Apr 2020 19:35:50 +0000
Message-ID: <DM5PR2101MB10478227BEEBACCDE8999CDBD7DE0@DM5PR2101MB1047.namprd21.prod.outlook.com>
References: <20200406001514.19876-1-parri.andrea@gmail.com>
 <20200406001514.19876-12-parri.andrea@gmail.com>
In-Reply-To: <20200406001514.19876-12-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-04-10T19:35:48.1491159Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fddb7a8a-9772-434a-bd46-0b042666aa95;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9f623075-c217-4232-f307-08d7dd866049
x-ms-traffictypediagnostic: DM5PR2101MB1109:|DM5PR2101MB1109:|DM5PR2101MB1109:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR2101MB11092514A9F10E78022F7F01D7DE0@DM5PR2101MB1109.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-forefront-prvs: 0369E8196C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR2101MB1047.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(136003)(39860400002)(346002)(376002)(366004)(396003)(10290500003)(478600001)(110136005)(71200400001)(2906002)(8990500004)(76116006)(8676002)(316002)(7696005)(186003)(54906003)(26005)(81156014)(5660300002)(66946007)(86362001)(66556008)(8936002)(52536014)(6506007)(66476007)(66446008)(4744005)(9686003)(33656002)(4326008)(82960400001)(64756008)(55016002)(82950400001);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +y7d47Iq8RlwilR37jw4R7/CIRjGjb7MoZm9DChLxueBjlbGiXXb5sg+alRKY4aIPWynGaj3yTpszDxZKOlvpFhH5zcCPWwEatYbjVebvmT0ubaMHoPMAzP9Dn/aJEKCfF0bywKqUO5gYZCEtdyBAf31qR6gG4NebVmDgTl0hO9AHnj3B2fR5G+zXaPwZy7cEOkdMJxQ+eWpsCS+ptIHMQ6h7oS/xzSGCd3vXIrSiwtp/1Ky9w5NGL6iYZRm4YCqe2yESGkxlWLys9J/LzNeTzqAiWGXfxNE9E+YKnocE1BKji9AeRIUoH3eXseGFBN5ytz3OtXmAjjlo8weHjwAC/ygws4FPZ/b734OZfw5iqsVPRwjTIRigpXft6rUljK3S57YDwtTwdetZy1VM5IqPqwTSZjJ/Tnb/EwHm9gRDgo6XHfi/YAgrIkAgGgwHtkx
x-ms-exchange-antispam-messagedata: CVzmm4ILzhIu/gfquxqyY4RYifo6M3h10px6WV6AmfhiZ5BWVnJRwGc8p4GotOXKWxGr2TlYeQYaFbMqM+mAXcc63l5dy63ieBOtgA+UoQ+J2DLq7hUPqx5Y4zk8UJBhUhAHE5LHl5mEw3aSDgQSDw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f623075-c217-4232-f307-08d7dd866049
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2020 19:35:50.5870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: us4alahFVfMXVL6s29m/zMxDXsOZlKQgs0zhH23+qSNfh3me57en3DRhy1lSxdOrQ3gsSX6o6hrC5T0GHPHT7cVsb+AEU+tNaoH9QinRfcs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1109
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Sunday, April=
 5, 2020 5:15 PM
>=20
> For each storvsc_device, storvsc keeps track of the channel target CPUs
> associated to the device (alloced_cpus) and it uses this information to
> fill a "cache" (stor_chns) mapping CPU->channel according to a certain
> heuristic.  Update the alloced_cpus mask and the stor_chns array when a
> channel of the storvsc device is re-assigned to a different CPU.
>=20
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: <linux-scsi@vger.kernel.org>
> ---
>  drivers/hv/vmbus_drv.c     |  4 ++
>  drivers/scsi/storvsc_drv.c | 95 ++++++++++++++++++++++++++++++++++----
>  include/linux/hyperv.h     |  3 ++
>  3 files changed, 94 insertions(+), 8 deletions(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
