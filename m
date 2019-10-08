Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87D4ACFACD
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Oct 2019 15:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730683AbfJHNAb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 8 Oct 2019 09:00:31 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38151 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730439AbfJHNAb (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 8 Oct 2019 09:00:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570539630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=25SGDAhtAVwMxgYBLJztMuhf8UXGP63ScuWL8gNPwyY=;
        b=iexRR4iP7d4714LUtUiIBK0+IlytIaPuSusRO6e5ga2Y48TYfzPHaBCiczRKVj9btOYu1X
        5ji/xRSWd+19Y9C+TYDIggBdou7R0PbkDCJitCm4VJcUMNww62ne6vpGY8wI3Cqupjpndc
        tjYu76bM67I3T3wckMSuZOe14jN7COI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-ClUYrVa4PhOcHp-FM1zdtQ-1; Tue, 08 Oct 2019 09:00:28 -0400
Received: by mail-wm1-f70.google.com with SMTP id f63so947090wma.7
        for <linux-hyperv@vger.kernel.org>; Tue, 08 Oct 2019 06:00:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=lgFAVfH4gHJ873MMlUdQpwbkdKDcdf8fglwECqOAC/A=;
        b=ExzHTXCX0tBX1YRZy0CjmSduuhMhh0DTAgZA7FIqwUwURTnekqlj39Ln2Fd9N3byBZ
         NW6rWdUMkzqSxFQpkObmThyXGo+Pt6S9m1qaDUv3zflmh12KWhEAlLsDTRXUwRYJ0Ap3
         1Er9+3IB1IWYeiXWCAlgNqsLi3mjwLZl20PnWN07Ivh1250R+VSHl3M2anFVIn0GCZ+K
         AsHaYd5V74EYNCPtVKfq4eOb7LqfLmw1RxnaCXDvpQXeqpReO6rHEAQCa2A2go8rV/L+
         7sHwQygVV5wNHS0m5hmpX/40JhiSxKFdFZIlmV7XGOB/K267HkERfUHGCX/wCNzvuBc8
         Pt7w==
X-Gm-Message-State: APjAAAXW9q5AalYAbbS5JCColWW3fIfP8e3JldRCVti4pOINDPXAZ1jQ
        PLuZd0EOUBDltMpOgawUCX3go1dgd4pyjvVbkz0OyVHacHkjJQ5BapvncC5rb/pwLSEzBWmZfkC
        oY21xXBzZaXDl3Cs04eTWyr/k
X-Received: by 2002:a5d:620e:: with SMTP id y14mr2743090wru.337.1570539627457;
        Tue, 08 Oct 2019 06:00:27 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwKyQmxQY7wc1q8P+7MLUsSSqE5z4zZJqx7BcDykmc3jhMv5OuucnZNr4xwuT8fxXLxhUSlDg==
X-Received: by 2002:a5d:620e:: with SMTP id y14mr2743081wru.337.1570539627206;
        Tue, 08 Oct 2019 06:00:27 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id x5sm32090752wrg.69.2019.10.08.06.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 06:00:26 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH 1/2] Drivers: hv: vmbus: Introduce table of VMBus protocol versions
In-Reply-To: <20191008124052.GA11245@andrea.guest.corp.microsoft.com>
References: <20191007163115.26197-1-parri.andrea@gmail.com> <20191007163115.26197-2-parri.andrea@gmail.com> <87eezo1nrr.fsf@vitty.brq.redhat.com> <20191008124052.GA11245@andrea.guest.corp.microsoft.com>
Date:   Tue, 08 Oct 2019 15:00:25 +0200
Message-ID: <87zhibz91y.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
X-MC-Unique: ClUYrVa4PhOcHp-FM1zdtQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Andrea Parri <parri.andrea@gmail.com> writes:

>> > @@ -244,21 +234,18 @@ int vmbus_connect(void)
>> >  =09 * version.
>> >  =09 */
>> > =20
>> > -=09version =3D VERSION_CURRENT;
>> > +=09for (i =3D 0; ; i++) {
>> > +=09=09version =3D vmbus_versions[i];
>> > +=09=09if (version =3D=3D VERSION_INVAL)
>> > +=09=09=09goto cleanup;
>>=20
>> If you use e.g. ARRAY_SIZE() you can get rid of VERSION_INVAL - and make
>> this code look more natural.
>
> Thank you for pointing this out, Vitaly.
>
> IIUC, you're suggesting that I do:
>
> =09for (i =3D 0; i < ARRAY_SIZE(vmbus_versions); i++) {
> =09=09version =3D vmbus_versions[i];
>
> =09=09ret =3D vmbus_negotiate_version(msginfo, version);
> =09=09if (ret =3D=3D -ETIMEDOUT)
> =09=09=09goto cleanup;
>
> =09=09if (vmbus_connection.conn_state =3D=3D CONNECTED)
> =09=09=09break;
> =09}
>
> =09if (vmbus_connection.conn_state !=3D CONNECTED)
> =09=09break;
>
> and that I remove VERSION_INVAL from vmbus_versions, yes?
>

Yes, something like that.

> Looking at the uses of VERSION_INVAL, I find one remaining occurrence
> of this macro in vmbus_bus_resume(), which does:
>
> =09if (vmbus_proto_version =3D=3D VERSION_INVAL ||
> =09    vmbus_proto_version =3D=3D 0) {
> =09=09...
> =09}
>
> TBH I'm looking at vmbus_bus_resume() and vmbus_bus_suspend() for the
> first time and I'm not sure about how to change such check yet... any
> suggestions?

Hm, I don't think vmbus_proto_version can ever become =3D=3D VERSION_INVAL
if we rewrite the code the way you suggest, right? So you'll reduce this
to 'if (!vmbus_proto_version)' meaning we haven't negotiated any version
(yet).

>
> Mmh, I see that vmbus_bus_resume() and vmbus_bus_suspend() can access
> vmbus_connection.conn_state: can such accesses race with a concurrent
> vmbus_connect()?

Let's summon Dexuan who's the author! :-)=20

>
> Thanks,
>   Andrea
>
>
>> > =20
>> > -=09do {
>> >  =09=09ret =3D vmbus_negotiate_version(msginfo, version);
>> >  =09=09if (ret =3D=3D -ETIMEDOUT)
>> >  =09=09=09goto cleanup;
>> > =20
>> >  =09=09if (vmbus_connection.conn_state =3D=3D CONNECTED)
>> >  =09=09=09break;
>> > -
>> > -=09=09version =3D vmbus_get_next_version(version);
>> > -=09} while (version !=3D VERSION_INVAL);
>> > -
>> > -=09if (version =3D=3D VERSION_INVAL)
>> > -=09=09goto cleanup;
>> > +=09}
>> > =20
>> >  =09vmbus_proto_version =3D version;
>> >  =09pr_info("Vmbus version:%d.%d\n",

--=20
Vitaly

