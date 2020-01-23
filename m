Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E50F146311
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Jan 2020 09:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgAWIL0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 23 Jan 2020 03:11:26 -0500
Received: from mail-eopbgr1320111.outbound.protection.outlook.com ([40.107.132.111]:28701
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725785AbgAWIL0 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 23 Jan 2020 03:11:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wr53sCFlJta4dbUQKY9WFiY3PFEz2KxzVRjLs6kCUM+9qcbcHMy5+NKyOQcA7msLCJ63nMk59u9t0w8tZ7+/v9ObwRr6vkFywZNg8M4a1xD69FbrzV6R2nBy+dUtm56GEYwjzXyWbb+XzJ8FYkD7IgAv7tzwEVJtNzgmOSm1AUft6zzMbzpyOMJW5RaQe7wWBFcuNkC4JGw6hpz3JOpe/JK2iJDa1xPsh1GHCkMWnWC5NF+rCVFezStniVolpwY3/Di3wbmY3N/d7efPLjwFo2qqH5FwxkJq2AeFKUPBPJfs8hWOVZVKN7ZXH7uLi2S0FXKT7iomjc6PemdnTZmnMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVuD3UJ6cNGajxKdfqoJKNoHNF/96yYhKtMAK3kfaAk=;
 b=NDfHTVlRvG41J5JZtDWDeHrDPHTtas3eOAGIe1yjHoMG+sLlI66gl1MmBnraBrfCTwRWzgVh3ZnLj1x7ROo+bpUNi6D9ZO02j8AdKPXEQ5teyoeBPX1ddNqLLUCPZEOb+vfSZNIf9sOvwXj8SUPtQhvMhExD3D9paecay8LIYK5k9GCThTl0pCOx91YBFAKSP2FD0dTjJT+TA5PXv5nsUGMgbP07+iPA02CkCsfTDWWwy7yabICDn4V0mG8sl3mqKPoBv65Ghj7mgQax9sS05dwP46TvsncuroLDgyhHv+xiIP+YJdt8zQB6IMwQJ9/KrlKy+KQHaLtBv4MW8yzzFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVuD3UJ6cNGajxKdfqoJKNoHNF/96yYhKtMAK3kfaAk=;
 b=A0cq919WF/gs25k5qW1cPB0RFP3hZcteO7m8QNGSXlu44tbi5RyiPnIlz1BhG62XHP3W1llkLlNfFu+daUpZ4cGtKX4oByQUKNsyy6i5REek3etYNDXdYB/Z2IRl5iWwQq87C/uR/MNlt1vCGYXtkChkTFfh1YErTGKGUCIWIqM=
Received: from HK0P153MB0148.APCP153.PROD.OUTLOOK.COM (52.133.156.139) by
 HK0P153MB0259.APCP153.PROD.OUTLOOK.COM (52.132.236.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.3; Thu, 23 Jan 2020 08:11:20 +0000
Received: from HK0P153MB0148.APCP153.PROD.OUTLOOK.COM
 ([fe80::58ea:c6ae:4ea3:8432]) by HK0P153MB0148.APCP153.PROD.OUTLOOK.COM
 ([fe80::58ea:c6ae:4ea3:8432%4]) with mapi id 15.20.2686.008; Thu, 23 Jan 2020
 08:11:20 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/4] hv_utils: Support host-initiated hibernation
 request
Thread-Topic: [PATCH v2 3/4] hv_utils: Support host-initiated hibernation
 request
Thread-Index: AdXJ2xmWH7nlZvI9QtW52nKT4iLjSAHbmnJgAB0F21A=
Date:   Thu, 23 Jan 2020 08:11:19 +0000
Message-ID: <HK0P153MB014846CCBBA8C989EEC8819BBF0F0@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
References: <HK0P153MB0148FDF9A3AF2352544E6DADBF350@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
 <DM5PR2101MB10477532BDC475656FA3817AD70C0@DM5PR2101MB1047.namprd21.prod.outlook.com>
In-Reply-To: <DM5PR2101MB10477532BDC475656FA3817AD70C0@DM5PR2101MB1047.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-01-13T06:31:42.4306444Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=90e4698e-3fc7-43d3-857c-c415f1813480;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:21c4:4274:62b5:126b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 71733632-e6d4-48a5-c046-08d79fdbd444
x-ms-traffictypediagnostic: HK0P153MB0259:|HK0P153MB0259:|HK0P153MB0259:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB0259D07F7F56E945FFA2CE44BF0F0@HK0P153MB0259.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(199004)(189003)(86362001)(10290500003)(110136005)(478600001)(186003)(8990500004)(81156014)(33656002)(81166006)(8936002)(8676002)(2906002)(7696005)(6506007)(5660300002)(71200400001)(66446008)(66556008)(55016002)(76116006)(66946007)(52536014)(64756008)(66476007)(316002)(9686003);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0259;H:HK0P153MB0148.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pGv2a0i4Ax4X6sIHQz1C620uEfESertby4dROueKGbh+BEqJMCgKQanR1EInyHr22YP9dZaESxZNK5w+Et/O6YfyUcYjVK6MMJEUFysrPy1zf89SG7sPiq5nwSxGSTA46/JrXOSbwr7WmnnWnHtYnkFS22XGUEBdIsIEUveU1hc/ROJTJT18TjqENn/yHiiP/q9uQUdaEr+O2z35CovWf1xKW6X2spqye00AUiE40COx8FNNwRvejvZZHOnF1FCF5GkpvA5vLcrYlpWliOPk1gpSdEkPbLD6l46eyveElNgisSjRcYdPP5zuQ0tIzknQ2yZtfvzmZhjOxObyWsqlFA+K0Q25sCt6gC2vlIZJvXqheTsD/Z7Bnhv6fDZ7/FIFiBDtvgci+afCc6QY3jJ2bA8Dx2Z040q7fWV/Moc8zzzTBXSEAr/94WeOo04Grztl
x-ms-exchange-antispam-messagedata: JBbzX7HkdIcg0iMGmSBiTPJ0zYoEbDLQgc0gMICFFRQrtpj8QEojcb2mUnejdF8Lg66L07MrFDLUvZ1zcmlBlD7xQhNu9LmIUNtQDGXhVdv4ruGE8iucKeGbQZL5wqcE4WEkYgiia0tlKX7V00LQJQ27frA5ZJ77qwwrekJYTd9CE3VNvbdbDrlh3h7KETNuzReFmULt/oEIyKwxruks2g==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71733632-e6d4-48a5-c046-08d79fdbd444
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 08:11:19.9536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MY0i3KXmfghov0c0BASa9THgnz7mKZct7FOdUPA5fmVqC89rVkMMG3T9uCiXEvMC9oIl/oes4KNNS4/vJtH52A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0259
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Michael Kelley <mikelley@microsoft.com>
> > --- a/drivers/hv/hv_util.c
> > +++ b/drivers/hv/hv_util.c
> > ...
> >  static const int sd_versions[] =3D {
> >  	SD_VERSION_3_1,
> > +	SD_VERSION_3_2,
>=20
> I think these versions need to listed in descending order, so the new
> SD_VERSION_3_2 should be listed first.  Otherwise a Hyper-V host that
> supports both 3.1 and 3.2 might match on 3.1 first without ever checking
> for a match with 3.2.

Thanks! This is a rebasing mistake. Will fix it.

> > @@ -187,6 +226,17 @@ static void shutdown_onchannelcallback(void
> *context)
> >
> >  				schedule_work(&restart_work);
> >  				break;
> > +			case 4:
> > +			case 5:
>=20
> As before, I'm wondering about the interpretation of these numbers.

Will add a comment.
=20
> > +				pr_info("Hibernation request received\n");
> > +
> > +				if (execute_hibernate) {
> > +					icmsghdrp->status =3D HV_S_OK;
> > +					schedule_work(&hibernate_context.work);
>=20
> Same comment here about the ordering of the schedule_work() call and the
> sending of the response message.  Seems like the code should be consisten=
t
> for all three cases -- shutdown, restart, and hibernate.

I agree. Will fix this.

Thanks,
-- Dexuan
