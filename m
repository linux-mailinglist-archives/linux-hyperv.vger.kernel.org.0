Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6056110F3EE
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Dec 2019 01:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbfLCAkO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 2 Dec 2019 19:40:14 -0500
Received: from mail-eopbgr740101.outbound.protection.outlook.com ([40.107.74.101]:38080
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725899AbfLCAkN (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 2 Dec 2019 19:40:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TmvKn6pTRB2aRm6C92LhvuAjfUp2nYSPmJI/pnExNOtDPb9MkjBRT3zUPjvK9qjSwgN0XZVaiHH+4obQIZFn47URvbRK1McdcmA5wrSroQg10qsXPRdlBd+aGoXtzz2vV9ib34j1DLMt5EDLpWVMdJR+upvx7rdNyKfWu53nvy6lJ4OxiWXhNqt+OXMQ4blFrifvZPN8AX3+qrIVVJHIZC8enVA/OqgU1PUnr297PV15XofqfrZ/E97YuQ+O6nE9nJRR+DRonxwqUaHevMfE34SLRLwqzrx9sezsSEL+6AnIVn9VjprWOnvSQDGhr4+LgLq0gi/jzCSZYAMxnGDFfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpY0cSmVOo/Hih9bOgtiwXpRCY959kSuENLkTyDt6TA=;
 b=UGKMXq5sIL6N5vF2FT9TcK/XdJDYxR1fl8/u1R5uNb23AZ19P8ijhExnwzj6riIOylna5km3DDsm6HiaovCSlS5VD7jHKXjlNFtO0mA0Mm3hUxQT/pl1yMNfT05Lg53BIx0CQy2p44TcEpFEYrriEBAGC4ZUQxDcEuoqYsvt/jLIkgVOfGO8kbYJM4xrnuy/p4xL+4bRcaLG+qt6Js5F3Sy9ltl8FVQlu6AVS9d+PKyqn+HxsKPtoB5kNY6KbrzLcHULFoXFRDFmGdCSpM9g2u1MKECXo8z1ImubXIb3MkuBtFf6miBK3e2DfQVwvkExBz+3SzAjEecuaDyiL9V2PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpY0cSmVOo/Hih9bOgtiwXpRCY959kSuENLkTyDt6TA=;
 b=Jy/581m/bjlJe0CEd3TIr5EcX0z/1q5HpNBLdsCVGvLx1KHH1gVgOFij/xQ8/uTJdK+jqq3q9EI9LXj6Mzek4f3EQ1Cl1FQFJGc8iFrXr8fhGPJop429IAdkOOoM9WPAZyRD3Aobt/+7aMpLGF5NscFIpOZTSdx8OFsjPHCpIFc=
Received: from MW2PR2101MB1132.namprd21.prod.outlook.com (52.132.146.17) by
 MW2PR2101MB1068.namprd21.prod.outlook.com (52.132.149.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.8; Tue, 3 Dec 2019 00:39:31 +0000
Received: from MW2PR2101MB1132.namprd21.prod.outlook.com
 ([fe80::5499:4a0f:6079:dcb3]) by MW2PR2101MB1132.namprd21.prod.outlook.com
 ([fe80::5499:4a0f:6079:dcb3%3]) with mapi id 15.20.2538.000; Tue, 3 Dec 2019
 00:39:31 +0000
From:   Long Li <longli@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH 1/2] PCI: hv: decouple the func definition in
 hv_dr_state from VSP message
Thread-Topic: [EXTERNAL] [PATCH 1/2] PCI: hv: decouple the func definition in
 hv_dr_state from VSP message
Thread-Index: AQHVoaFZDrNNi9eblUS6WB9as+FYyaenjVmAgAAThZA=
Date:   Tue, 3 Dec 2019 00:39:30 +0000
Message-ID: <MW2PR2101MB1132A6039C540F473C9AD55BCE420@MW2PR2101MB1132.namprd21.prod.outlook.com>
References: <1574474229-44840-1-git-send-email-longli@linuxonhyperv.com>
 <PU1P153MB016971582C7371E29065D83DBF430@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <PU1P153MB016971582C7371E29065D83DBF430@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-12-02T23:29:11.3940351Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c6971509-4c17-459c-8ca4-1b8fc6fe4e74;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com; 
x-originating-ip: [2001:4898:80e8:1:eded:db5c:c6fe:798]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 56cf8091-35a4-45dd-e718-08d7778942e9
x-ms-traffictypediagnostic: MW2PR2101MB1068:|MW2PR2101MB1068:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB106836F4F30D262C9147AD70CE420@MW2PR2101MB1068.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(366004)(136003)(39860400002)(199004)(189003)(6436002)(2201001)(74316002)(305945005)(7736002)(33656002)(7696005)(10090500001)(76176011)(446003)(11346002)(5660300002)(52536014)(8990500004)(102836004)(2501003)(6506007)(256004)(14444005)(186003)(99286004)(229853002)(71200400001)(66946007)(71190400001)(2906002)(1511001)(8936002)(86362001)(6246003)(46003)(14454004)(64756008)(9686003)(66476007)(66556008)(55016002)(316002)(66446008)(22452003)(25786009)(10290500003)(15650500001)(110136005)(6116002)(81156014)(8676002)(478600001)(81166006)(76116006)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1068;H:MW2PR2101MB1132.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7bsszGTUL/SdWntnXQNk0vzbSFMKUgN30KHGtu0VKq8tVth181ZGgv37gj0T9ZSswnGAzaSuMQdv+jYsBEP4D6oijG1VmgvwG/NEUVD0AdaZMKN3137SEihtHdAjBzRypT0nGUfMd3gFnWpII9FSW+unoZ++iUt0ln8V7daeGoPn03cee2V8FMjpceYlEWsOL3r8JaaKBzX+Bc9e9CQeguUbewkLBFxYqrKcM3Bfi1IvcnTgzx6qrGUNi47ykoVpswMnkfUsOwW/LATkCVbQYQQvmAx1n/C3NF4CDOXbwoJ2bzl34jdSqQPltW+2tzitjkvBFECar+9Fd1UoeGdUshhljMjTOKXfnT4A1AJF3U4jOQj8aNp0B8TUz84UHbW5eBXTC0iQO3s7yB4UvAOpXSTRpt5pHAEqo9QL9SqYP7SdCCYTZ94Lq2qm0O4KRSsC
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56cf8091-35a4-45dd-e718-08d7778942e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 00:39:31.0885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gdUwYv+2+GOgnmpcz+P45tdQ4GOiqwopI2Qjwfzvm3v7KQHEE5le/FDppxGeoKJgjMjjrwMNUlaFaiyiW/bZ6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1068
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

>Subject: RE: [EXTERNAL] [PATCH 1/2] PCI: hv: decouple the func definition =
in
>hv_dr_state from VSP message
>
>> From: linux-hyperv-owner@vger.kernel.org
>> Sent: Friday, November 22, 2019 5:57 PM ...
>> +struct hv_pcidev_description {
>> +	u16	v_id;	/* vendor ID */
>> +	u16	d_id;	/* device ID */
>> +	u8	rev;
>> +	u8	prog_intf;
>> +	u8	subclass;
>> +	u8	base_class;
>> +	u32	subsystem_id;
>> +	union win_slot_encoding win_slot;
>
>Change the spact to a TAB? :-)
>
>>  /**
>> - * hv_pci_devices_present() - Handles list of new children
>> + * hv_pci_start_relations_work() - Queue work to start device
>> + discovery
>>   * @hbus:	Root PCI bus, as understood by this driver
>> - * @relations:	Packet from host listing children
>> + * @dr:		The list of children returned from host
>>   *
>> - * This function is invoked whenever a new list of devices for
>> - * this bus appears.
>> + * Return:  0 on success, 1 on failure
>>   */
>
>Usually we return a negative value upon error, if possible.
>
>> -static void hv_pci_devices_present(struct hv_pcibus_device *hbus,
>> -				   struct pci_bus_relations *relations)
>> +static int hv_pci_start_relations_work(struct hv_pcibus_device *hbus,
>> +				       struct hv_dr_state *dr)
>>  {
>> -	struct hv_dr_state *dr;
>>  	struct hv_dr_work *dr_wrk;
>> -	unsigned long flags;
>>  	bool pending_dr;
>> +	unsigned long flags;
>>
>>  	dr_wrk =3D kzalloc(sizeof(*dr_wrk), GFP_NOWAIT);
>>  	if (!dr_wrk)
>> -		return;
>> -
>> -	dr =3D kzalloc(offsetof(struct hv_dr_state, func) +
>> -		     (sizeof(struct pci_function_description) *
>> -		      (relations->device_count)), GFP_NOWAIT);
>> -	if (!dr)  {
>> -		kfree(dr_wrk);
>> -		return;
>> -	}
>> +		return 1;
>
>How about "return -ENOMEM;" ?
>
>> @@ -3018,7 +3055,7 @@ static void hv_pci_bus_exit(struct hv_device
>*hdev)
>>  		struct pci_packet teardown_packet;
>>  		u8 buffer[sizeof(struct pci_message)];
>>  	} pkt;
>> -	struct pci_bus_relations relations;
>> +	struct hv_dr_state *dr;
>>  	struct hv_pci_compl comp_pkt;
>>  	int ret;
>>
>> @@ -3030,8 +3067,9 @@ static void hv_pci_bus_exit(struct hv_device
>*hdev)
>>  		return;
>>
>>  	/* Delete any children which might still exist. */
>> -	memset(&relations, 0, sizeof(relations));
>> -	hv_pci_devices_present(hbus, &relations);
>> +	dr =3D kzalloc(sizeof(*dr), GFP_ATOMIC);
>
>Here we are in a process context, so GFP_KERNEL is preferred.
>
>> +	if (dr && hv_pci_start_relations_work(hbus, dr))
>> +		kfree(dr);
>
>Thanks,
>-- Dexuan

Thanks! I will send v2 to address those comments.

Long
