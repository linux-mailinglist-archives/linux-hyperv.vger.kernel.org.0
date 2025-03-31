Return-Path: <linux-hyperv+bounces-4757-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 045D6A77158
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Apr 2025 01:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 417D03AB1C8
	for <lists+linux-hyperv@lfdr.de>; Mon, 31 Mar 2025 23:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBE91A3BD7;
	Mon, 31 Mar 2025 23:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="dK9ue81U"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11020105.outbound.protection.outlook.com [52.101.51.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50FF3E47B;
	Mon, 31 Mar 2025 23:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.51.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743463214; cv=fail; b=olGdMqrIueJy2rJfmB0L4LSPo2lGgVlMDsZEbibHqx6CxrhkvtY7kCimUBrIY0L7fybXV2A0J+wCLuujkXkbM6ga5lxZGNqazvleEEqUPN+uA40714G0YfSfw4Yp7jNBZellbbnovUDKDC4XVHRj2H3hqZKSLJOBCu9vr2sCYlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743463214; c=relaxed/simple;
	bh=/AZq0GSBsh0M+NqqiGkDc+uuhEOt2Y89WHoDmDHwHLw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MlxpuLmWCn7p7RQ3kKNwR7a2FmuIZ5PNmvJEldpqdzHzzVYCBjEFjdzg9e1ZTTQpZjrHfrjL9ZqUa+XpFVwlEfWzdu26bIHSRgY7cOly9ckRCkXBLtqyQE7Fg8SI04Bnivvq/ZzmgP7t9N+UxVY9QnyTiL4Xn/s59/wQZ6wat+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=dK9ue81U; arc=fail smtp.client-ip=52.101.51.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dZU3baWDHkkpBDrJvxLccY2vWEv7EOsYM9/94Ep7X7uqEM592ib7/NskOlt4Era7rB/wtG6KDjCff868ih0nBif+b5a7haZ1ZvK+WMyhjhPMQMP8OaVtyJvyI6w/zwwN51+CkPyKIeDa5oR8xXzZZ+CH5y/pPXLSt7rfSztH0h1zrG5THQYm/79zueWkoxd6Jx8+/lBVEDOBhN9raNQi/4hIgcOPqi6xI2hxLalnVhdA+WoM4S9eGo3vsxlPjYCHniu27HxmnpYtrRBtAK4Zaw3BEq8oPI5MWcnVu3SBS1XFvHuYpLAH+7+OShCoS6QrSbknzkI4yTUQK+J3M+iNSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+h/4+Hq00HYuQDt4V3zIUOtYQx49wFCmNufRdUivfU=;
 b=tPoULVeKkwLQ/wOH2lDEqnY69/AaNme19kzzrybtQ9BKdaNNUn+J1PiFgzAoTk9l+FxNwSPkylja76Q7Db8xq8y33qhvzrWuB+W3hCVA0FwzgxrtJpM9XtiUuZa3ukxundpLBZxIW7VN/AEUWn0vFgsoKVObVEH9zw3zM7z4chbVliEwziPn00qS4ZMoGAS4xFHO8yVhuNB49UTnlnbDqpQ/gJVjYkQCfVRcKxtFyoqBSrIDbdiTDr0G0frBlZMQ/bDF0lLugIPhQurEY0mEehVG3AzsADCCWn5/MJGVNOivGVeHZaqV+OPGDirFR6N54t2PQ0u/blaivGfXIckiQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+h/4+Hq00HYuQDt4V3zIUOtYQx49wFCmNufRdUivfU=;
 b=dK9ue81UIL57pam/2Zs9neqJ1N0V16fwHDzKxhGQZWjis3+sJ8nW+w639oS5FWeChOWu1Gr60WAVaa0MJoDZ7dbFucy3l/O3FCv4TQV/m7bohj5AeuDWzBmdWzqBioqnfX+TMeV1ksyAXXA2nYeyraxQ+jJq2b5XTQxTZWg8CTM=
Received: from BL4PR21MB4627.namprd21.prod.outlook.com (2603:10b6:208:585::7)
 by MN2PR21MB1486.namprd21.prod.outlook.com (2603:10b6:208:1f7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.16; Mon, 31 Mar
 2025 23:20:09 +0000
Received: from BL4PR21MB4627.namprd21.prod.outlook.com
 ([fe80::7cb1:a2d1:137b:34fb]) by BL4PR21MB4627.namprd21.prod.outlook.com
 ([fe80::7cb1:a2d1:137b:34fb%7]) with mapi id 15.20.8632.004; Mon, 31 Mar 2025
 23:20:09 +0000
From: Dexuan Cui <decui@microsoft.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Shradha Gupta <shradhagupta@microsoft.com>
Subject: RE: [PATCH v2] hv/hv_kvp_daemon: Enable debug logs for hv_kvp_daemon
Thread-Topic: [PATCH v2] hv/hv_kvp_daemon: Enable debug logs for hv_kvp_daemon
Thread-Index: AQHbogQ4C/lFQDjS3kCzOLhPcF8IYbON2/SA
Date: Mon, 31 Mar 2025 23:20:09 +0000
Message-ID:
 <BL4PR21MB462765E191592754911DB67BBFAD2@BL4PR21MB4627.namprd21.prod.outlook.com>
References:
 <1743401688-1573-1-git-send-email-shradhagupta@linux.microsoft.com>
In-Reply-To:
 <1743401688-1573-1-git-send-email-shradhagupta@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a35e71be-f2d0-40fd-b86c-0babf6e978e7;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-03-31T22:55:27Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL4PR21MB4627:EE_|MN2PR21MB1486:EE_
x-ms-office365-filtering-correlation-id: 228b7870-67d2-43ea-61d4-08dd70aa94bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Jp8DHvQtCLAKjb8ctmP4g0SEwqFtHqrNnGrkvbcIk/9nmzOiMce90T8+PyP5?=
 =?us-ascii?Q?5vfUvY/gOsTpdlvC8/U3OPQWgOhUJnN4b37aXPabSNuzN6PQUeWKY75OQhT8?=
 =?us-ascii?Q?jEM1K9IeRcnNMm9E8z6CZ5HM9M41yVgKKJ771voEMeNdYsdqy8zu3Vlkijqn?=
 =?us-ascii?Q?0tl3Tg42Jw9jb9rnDkNvzoboMYLTYYg3Nke7gHyWMNZMgIyubKFPeZxHA7/r?=
 =?us-ascii?Q?LapKtDbdNI2TbBZGGkYUKSgdrNsjo5FU3mTXg6io91SHCm4SqBfv6dIp8uBY?=
 =?us-ascii?Q?eK85/C3Y5IN1kMWa+RH7Jlw3liVel7qd1/I5idDciXCubMzi/cT7OzPi7a/0?=
 =?us-ascii?Q?9VDQVgBJ5mzzRtWhckyHMgGO8no42AA7lAUt7LTKD3MpP1ytqdy2gxywx3VN?=
 =?us-ascii?Q?sJ1VhahA5bGxPJj57elxm+t+nRovTyx0G+MW/bSAWEnWpZYWdJL+GAVk8+IG?=
 =?us-ascii?Q?56VY3/Bcea6vBm42woxRLJMPeG+a/WwXS2CHpOvzoJdrLXhkbNkZoZOjpcKN?=
 =?us-ascii?Q?NGgeiOphzxg5ehpSdR/irc72K2JC1DPdksPnu2GJz5YQmLfXZbAbiEzocG3h?=
 =?us-ascii?Q?CE0MgHwhJjLCJ+isBaoMnXeHmSJHF2HyY8SHOeBMecVFXwal9xBnCwddMJCC?=
 =?us-ascii?Q?0fK85W5kF5fxcSFeRnk10wDp27mD88rBeOqRp7kmZmv1+IS5GbBDrc7NG56G?=
 =?us-ascii?Q?U3xaVV74Ywp/W0n/+jXP1w5Qh4/QcNtLsrvjLDu4kttIZDQHDDyFd8KaCGpz?=
 =?us-ascii?Q?PcyBsAq7xxihi4TGkd8f3Ismdvcuh0WiCyiMskyfhK2kVnyrG3Fo4EKzmffR?=
 =?us-ascii?Q?3Jqw3Y5eonyvJEwb3jV7AGhj37z+Ho1qBGwa5zz9zJxyu9776XzWCqeXAKIG?=
 =?us-ascii?Q?1xWgJO/4xd6cnlGONZNtcS9LaFdh5lErmY5RpIuwJrqUl1mL1yXY3+rYxO+t?=
 =?us-ascii?Q?Y2eoO1vPEHgQkUG33efV8NahpIC1rmlwFqlVZ1K6zmxJDs/Ai2b6jtrxlVvm?=
 =?us-ascii?Q?ZryWObP47J1uFl4BYoWR0ektya54zC+S7SW3GO0uRs1844IVGg2LopNDGL33?=
 =?us-ascii?Q?oFdf7jcLIHQh/U2T+IBBpnaI6Gf3mvMzyXrCQz+nbsR2Ad1DUXfbslpkVzYL?=
 =?us-ascii?Q?7fzZMYu78sQ+IMO4T1obqhPJgdjOTixTULnaT+m4IRNsbWNk8vNV6J19NaMf?=
 =?us-ascii?Q?cEvN2iT4SRR8awFbAZCkP5RG4KD/lNRuN65PiyxTgZRISxZUimfpwV75Cjkd?=
 =?us-ascii?Q?sbGZf1ZQ5gj9yUTCl042ECVAYhhEH/JPyiTDVJeNBOW8p/4d8BPEn67+N8ld?=
 =?us-ascii?Q?jmMbKtePq7TS1uuolOxKMFO2VQJeiIpEYMiH0Lgys+oOFho4qOnhysTy8a/0?=
 =?us-ascii?Q?ZipkA1C4v9mjVsX78Kwj4EWpcmOQBvnc1x4kwW+7WiGlDpqaknzztnY2cttu?=
 =?us-ascii?Q?tExR2UxmzlrajDtB93tDAq1ncWBixftWrxVoVg01cQe9+aZI9P71jw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR21MB4627.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?j2LhRXszvA0gqmDmS11o8vK6Riulk8BqbIZgRn2k5DsAmH/PANDVQRl0gK+Z?=
 =?us-ascii?Q?ZUAZeR+0xcRYN4ZKi9iGJa6UvTLaFMT4wiD2BEo/PNSpDRIUSS/Ysv3ITRII?=
 =?us-ascii?Q?u0N3LFxNCD1tJWMgBuCSb+5o8ZvcLMD8j3F5O3ZGCe7GyL3E6jg23WQ7KbTI?=
 =?us-ascii?Q?l7v4mJtLI5UqBfQEdkwH6EPW1wkJzSPqecbhS7qvDn7gl8kcfHKOv5dgxpZp?=
 =?us-ascii?Q?96+KVkHp82KMphaZk1x3mUqMlb4Qz0zPEl+sBt3u8C67py1sxIWoWpAzgDjp?=
 =?us-ascii?Q?+8ntb9JQEkKzq031/s/h/gKD+YORKD+jAUzv0LPw7lQhjIlY2h1PtioxTBB8?=
 =?us-ascii?Q?3Em2SW32ZiKQa4vXl1XYNOmYTPmqkq9nfa4hx6oN8iVOOXTad4O7mMM+j483?=
 =?us-ascii?Q?X2Ty5P5WuNnYOESuZwEavkl5+boXUfMxfuvRfPLfsGJKT2DIpNvXxesAe+r6?=
 =?us-ascii?Q?5GTBmjc0hmkxsKuiEVloMdTNNhCUfj5lf4qGK4WSIo/dAkEVGc8wnVHDl0Nj?=
 =?us-ascii?Q?fD1FWHQrNFqgCYsNEOR4jtFop7NWCxIo9DLPockafajUxUcuuNOVBUsk42l9?=
 =?us-ascii?Q?HKjxhvZJQWC5GPIyXjalB1+lWPsMCkoo7nuhSnvxnL9Ayzq1yeXcf6+MdGuE?=
 =?us-ascii?Q?OCxYdlop+Hts1o1s9T2bx0j4p5Ayzw/c/SuFhLU1Re+GzClOJmUXsBVi21Ll?=
 =?us-ascii?Q?8u89nYfuX+AUgDKTISBFn7x2z1a6PBu28nx/mD7HdOI3975uFvgVxCI0a4vq?=
 =?us-ascii?Q?CXqPFwBq3IuHZRJX/tyJO3DZSk2lpHBiRstEFKb91k4tmbZ1k1nB6WSKo2WA?=
 =?us-ascii?Q?hA6YD42KvXKlWRo79nbZQSi96KS9CTWcYbWU8ScPvSieQVXBPsIMPFtJmFeO?=
 =?us-ascii?Q?ULYDNwABq7kfVw7yDA3Bn3p+tRuyAaHGAp8dO63hlK6VKZO4Upm++Dc2iF8G?=
 =?us-ascii?Q?dbH3jP351PtHnM7dJoL6HMYxFQ/MLJAv63DF6G7nIuqiU05sXni+ExpClNBY?=
 =?us-ascii?Q?+TfhgmDSSCa51PnM0A7qetYNMIhKhQD6KK06gPgDdsP86QeI/Q6/VSw6btCd?=
 =?us-ascii?Q?xGE5RXXE7aziMyEVHkffCckRajfGizFO4pXEg4wC9CWW4Vprwg09WqUp2/uQ?=
 =?us-ascii?Q?yOFinTNXdboDYq9BHL09jsm684ULSqc2I0GtBG8U2fQ3V79E2LYBTLBa/+pd?=
 =?us-ascii?Q?Ig7uJ1KGUFfvphiJDgMdz8P608EMO+Fj1UWC/o+wHXgtHqPlEnXxT4I8xRSN?=
 =?us-ascii?Q?6hmG5JW8Q7BcrOsVweBI8UAuQUa4vJ0p1kzqUz+L4h610sEoAtXfQQz4vAOY?=
 =?us-ascii?Q?SY4CRY9e6mEL9VlPbmOD3iBIzdRQMFK9145PiFmCw/nX6Eu+WhbdoiYjTz6w?=
 =?us-ascii?Q?EjhiUr5GA++/mougwM0jKhK2DkBz+lUxU2A0XjUwsxnr4mdKuyzW9W6gsSxe?=
 =?us-ascii?Q?kui228c53ubX4m+HbD4YbncXXsUda2Tt/ycarU+afXnSnC7wKxo6hqPOs/fQ?=
 =?us-ascii?Q?SHQobIM95Mn6G66nFkjp2CvpbRwv8dJo1zNZBDskaKfYL3GAwWKo4ABTjQfR?=
 =?us-ascii?Q?31f9ju3gqgiNh7h4uujMy+ASjIYeVuKR6B3or2EPeAYI6FZtOC1u5KkTzRJ2?=
 =?us-ascii?Q?b1jLubFkD9MM1VBRNbUKkWQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL4PR21MB4627.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 228b7870-67d2-43ea-61d4-08dd70aa94bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2025 23:20:09.8645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P6tPX0niwbfK5TEpX+I1msNPkoDWrs+/EGZDyXW3kEMV1FCNO16Mf8CioRdK4aBjLGPhgmLbXej8LsDrUVNu6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1486

> From: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Sent: Sunday, March 30, 2025 11:15 PM
> [...]
> +static void convert_tm_to_string(char *tm_str, size_t tm_str_size)
> +{
> +	struct tm tm;
> +	time_t t;
> +
> +	time(&t);
> +	gmtime_r(&t, &tm);
> +	strftime(tm_str, tm_str_size, "%Y-%m-%dT%H:%M:%S", &tm);
> +}

Now the function is unnecessary since v2 uses syslog(), which already prefi=
xes every
message with a timestamp.

> +static void kvp_dump_initial_pools(int pool)
> +{
> +	char tm_str[50];
> +	int i;
> +
> +	convert_tm_to_string(tm_str, sizeof(tm_str));
This is unnecessary now.

> +	syslog(LOG_DEBUG, "=3D=3D=3DStart dumping the contents of pool %d
> =3D=3D=3D\n",
> +	       pool);
> +
> +	for (i =3D 0; i < kvp_file_info[pool].num_records; i++)
> +		syslog(LOG_DEBUG, "[%s]: pool: %d, %d/%d key=3D%s
> val=3D%s\n",
> +		       tm_str, pool, i, kvp_file_info[pool].num_records,

Can you change the 'i' to 'i+1'? This makes the messages a little more natu=
ral to
users who are not programmers :-)

>  static int kvp_key_add_or_modify(int pool, const __u8 *key, int key_size=
,

Can you add a log message for KVP_OP_DELETE as well?

Thanks,
Dexuan

