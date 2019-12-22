Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7DF128C5A
	for <lists+linux-hyperv@lfdr.de>; Sun, 22 Dec 2019 03:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbfLVCrW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 21 Dec 2019 21:47:22 -0500
Received: from mail-bn8nam12on2108.outbound.protection.outlook.com ([40.107.237.108]:48080
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726086AbfLVCrW (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 21 Dec 2019 21:47:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aW7Feh02JrNmZ4ciTF6Q09uREpy5bhUT+nqDKCjeP/8XURTGh7M10TqmR86Vo6h1cgqJIoGITVIYRsjeyBxmWZNgo5atehOEOSGC26UCL+QU4p3cSgZg8GhySAvGYVfjIx2QRkgNWHwhOpPQbbXrh5+0wrzj4OsmTDPvwbHS9y+LswQJSMUxTtYBsg/EfKlKQNyPy0BrNTeD7KvaCdWGmLLUqq8U3Kib1o5eY/hjA8qORtvUhuoDSGB9zmPyg1stXHlijUJmAgGayDOXT2XJR41k6DZBpaxlZRBDodHObWPOSFre46bKuo/MF1SNSuVazi5lUf2f1r+VWzyH/gQSCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryWy730AfZJEmX9DTlZkXvUgjg0wzfiJYX4DSym2QXM=;
 b=jx0DOZX0mQch/ICbLsXoCZ7RyPBWQnXPPtjuj291otNRhIbDkeFSHK1twfCnUR/NZaBwE+vkD2OfdZIOsVVLnlykKhEHYl5DWrEquOrFCVbDHx+IxUGgcb3TGkoDd9AfkpJxdg4NPpzkQf1m7t4PJB4sQl4X1GoBWlwo6LFN63QlDgO4zRPcNUaTVT/Vx3fpg+JTGyviRkLRMDXdtp4Og3RFJklbr2PKDtk8gIpqwj6qNvPeKppxV32hYS9VTSMEsK2uTwl5S+8v0g3t/Aqut6I1JLuyoPDa7FsrOwn37YJsK8lK94yMkPq3Yk2XXOyI4AXtZ72yYyrJ4fg4QtdB7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryWy730AfZJEmX9DTlZkXvUgjg0wzfiJYX4DSym2QXM=;
 b=W6JHmwRVBJpgxxQ9kA6jbtdWJfZKxe2uqVnMX7gH5Yh4193VkzhoBGyu8okojdD33jZDLCX7jhHvKulVuDbqueyq4m2cqsD1i+WAhhHNgtAThSz8gbrXWVQKR9qQHazNF+nez3ZWrBi/4SFjp6F6ADc6e9eeBQIoNNGD5229sFQ=
Received: from BL0PR2101MB1123.namprd21.prod.outlook.com (52.132.20.151) by
 BL0PR2101MB1121.namprd21.prod.outlook.com (52.132.18.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.10; Sun, 22 Dec 2019 02:47:19 +0000
Received: from BL0PR2101MB1123.namprd21.prod.outlook.com
 ([fe80::602f:c781:a5ff:39f3]) by BL0PR2101MB1123.namprd21.prod.outlook.com
 ([fe80::602f:c781:a5ff:39f3%3]) with mapi id 15.20.2581.007; Sun, 22 Dec 2019
 02:47:19 +0000
From:   Long Li <longli@microsoft.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Patch v2 1/2] PCI: hv: decouple the func definition in
 hv_dr_state from VSP message
Thread-Topic: [Patch v2 1/2] PCI: hv: decouple the func definition in
 hv_dr_state from VSP message
Thread-Index: AQHVqk4NWoi5w81JaEWb3p6WSpwllqe0Fc8AgBF5lAA=
Date:   Sun, 22 Dec 2019 02:47:18 +0000
Message-ID: <BL0PR2101MB11232C53CC44A092F7B0C7C9CE2F0@BL0PR2101MB1123.namprd21.prod.outlook.com>
References: <1575428017-87914-1-git-send-email-longli@linuxonhyperv.com>
 <20191210235450.GA177105@google.com>
In-Reply-To: <20191210235450.GA177105@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com; 
x-originating-ip: [2001:4898:80e8:a:ede4:db5c:c6fe:798]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 737faf64-1d2f-43fe-7d9f-08d786894341
x-ms-traffictypediagnostic: BL0PR2101MB1121:|BL0PR2101MB1121:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR2101MB1121144FB621CE331A3B9186CE2F0@BL0PR2101MB1121.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02596AB7DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(39860400002)(396003)(376002)(346002)(199004)(189003)(15650500001)(66476007)(66446008)(64756008)(66556008)(81166006)(4326008)(316002)(52536014)(76116006)(10290500003)(5660300002)(2906002)(71200400001)(478600001)(66946007)(7696005)(54906003)(186003)(33656002)(9686003)(8990500004)(110136005)(8676002)(55016002)(6506007)(81156014)(8936002)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1121;H:BL0PR2101MB1123.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: szbOQH+QB/ebmk0xWe37Et7uE0z2HtQyXudLlB1iNGKj8tpW+w5yVfgW2Q4X0reRzV+KZADTbZzP+7sFmehM2woQcWZAyF9LcIrzNVcIawLjyL9ELIKA9JmDQV163D8X0MSSwjcr6UEjUzk9hJjdYKkhEXSmz2QZlEE4aiUAWyDguR5xNBD6imIBgEcMRhw3P7n1jIHtpPj1qiIoaKzd2ZVo92dhI6UnElZzGKHXH643o/hFH11okFdlNvArQxYdFojAMG5jxxx3F1zvEPZ2ijy9WEkbA/0ZvEZzFrnx5Hka4/o7hu79djZKaPRdrfYxtmUM0g3d/l3kH/ybMqDM/rUxv/1mLO085edMnxohLozJqnJsxQS6dQLGZuQwbDtkePyxTldU0XQcacsVY0ME9tNyqsNBzfIET4DTvz2dWnHZLaTSnpC9MOUUxy8/Iapf
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 737faf64-1d2f-43fe-7d9f-08d786894341
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2019 02:47:19.1372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B4Lvb3LOKSznFqWMXXatHHApKEigtMSL1m+FTGA4Pr3ykJWpOT7eGMrJnMTL/MtBIfXXmZ/6FW+kxlSGe+R5TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1121
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

>Subject: Re: [Patch v2 1/2] PCI: hv: decouple the func definition in
>hv_dr_state from VSP message
>
>Run "git log --oneline drivers/pci/controller/pci-hyperv.c" and make yours
>match.  Capitalize the first word, etc.
>
>On Tue, Dec 03, 2019 at 06:53:36PM -0800, longli@linuxonhyperv.com wrote:
>> From: Long Li <longli@microsoft.com>
>>
>> hv_dr_state is used to find present PCI devices on the bus. The
>> structure reuses struct pci_function_description from VSP message to
>describe a device.
>>
>> To prepare support for pci_function_description v2, we need to
>> decouple this dependence in hv_dr_state so it can work with both v1 and =
v2
>VSP messages.
>>
>> There is no functionality change.
>>
>> Signed-off-by: Long Li <longli@microsoft.com>
>
>> + * hv_pci_devices_present() - Handles list of new children
>> + * @hbus:	Root PCI bus, as understood by this driver
>> + * @relations:	Packet from host listing children
>> + *
>> + * This function is invoked whenever a new list of devices for
>> + * this bus appears.
>
>The comment should tell us what the function *does*, not when it is called=
.

I will send v3 to address the comments.

Thanks

Long

>
>> + */
>> +static void hv_pci_devices_present(struct hv_pcibus_device *hbus,
>> +				   struct pci_bus_relations *relations) {
>> +	struct hv_dr_state *dr;
>> +	int i;
>> +
>> +	dr =3D kzalloc(offsetof(struct hv_dr_state, func) +
>> +		     (sizeof(struct hv_pcidev_description) *
>> +		      (relations->device_count)), GFP_NOWAIT);
>> +
>> +	if (!dr)
>> +		return;
>> +
>> +	dr->device_count =3D relations->device_count;
>> +	for (i =3D 0; i < dr->device_count; i++) {
>> +		dr->func[i].v_id =3D relations->func[i].v_id;
>> +		dr->func[i].d_id =3D relations->func[i].d_id;
>> +		dr->func[i].rev =3D relations->func[i].rev;
>> +		dr->func[i].prog_intf =3D relations->func[i].prog_intf;
>> +		dr->func[i].subclass =3D relations->func[i].subclass;
>> +		dr->func[i].base_class =3D relations->func[i].base_class;
>> +		dr->func[i].subsystem_id =3D relations->func[i].subsystem_id;
>> +		dr->func[i].win_slot =3D relations->func[i].win_slot;
>> +		dr->func[i].ser =3D relations->func[i].ser;
>> +	}
>> +
>> +	if (hv_pci_start_relations_work(hbus, dr))
>> +		kfree(dr);
>>  }
