Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92732F3117
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Nov 2019 15:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389154AbfKGOPw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 7 Nov 2019 09:15:52 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58443 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388868AbfKGOPv (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 Nov 2019 09:15:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573136150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IQQGeA2GqC4Q8lGdu4U1hGsjXCIjFvgN1cEaPoJfzWs=;
        b=NtycCoo3RNlpb4OFNjVeFujY1NE3uyfu1VmI0WD+0cmVI0ZRpkME3EPFeisuJDz/GNTa53
        csGYHEb77y9vW9xIfpJC6HU+yn1dqRBoDWDTEaSED7z3qB/OVKyP3SSdA4hak8v52p2/J6
        4vSAOVeoICR3VBdlJNFZX4Aql90H+1M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-CS--QH8TO4G51UrR0F6FgA-1; Thu, 07 Nov 2019 09:15:48 -0500
Received: by mail-wr1-f69.google.com with SMTP id w9so239636wrn.9
        for <linux-hyperv@vger.kernel.org>; Thu, 07 Nov 2019 06:15:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=NuQrs5SJVY4jlHa2zxbalzQjTYTxUlDQ8ZHPfqmiNQ8=;
        b=VhPd5uarY7yYIyC+B/OfIJbcaNCyPzRudizGFa94pmdY45uML8FhY+K+rbwElaxTsr
         nzmqWqdJB7Z53eBHdVx7YiTMDIIyxmUB28ilcWki33vjgtMoy5EcNzL5hYzdklkx28bX
         EXQFnr98qkMxJH2Fu6r2H5Q7Ue5tsKqrwmSQvdFT5LZ0Owqr7KiyO89CLdWWP5PkIUjO
         9oFoOjtc06zPo1t9f2IVhdehvw+tqJi5ERlHv/2WChVqtZGg5XpNKZf6hbfQZ0nghRa6
         P41FWjW4CO/60S4UMoRf42dNFY4bNgBjxbKGv1Iay0K3E6QAzpqE1wHWo3/cZdrYkgZP
         WTzA==
X-Gm-Message-State: APjAAAURV09BS2AYhjJ6iKhY6+mwsKEvOcATjnHQb9CIBeuKkBeShcBG
        yhgIcOrOmlqb8TZ1mae7SXXYlY1sCb3BiKg/tnJ7nQpjNSyQjglVn0i1jpPcop2RGDW4+woqh00
        GaUEkoll59ev0HVKOydKJ5Fme
X-Received: by 2002:a5d:4982:: with SMTP id r2mr3134194wrq.254.1573136147571;
        Thu, 07 Nov 2019 06:15:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqzwgCFT8usXbCPQK392QCEz4oeVoY26l3u2JDtD2xITZhSqFPvEqq5eSP3DgLKVukd6BnLc8A==
X-Received: by 2002:a5d:4982:: with SMTP id r2mr3134177wrq.254.1573136147337;
        Thu, 07 Nov 2019 06:15:47 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id m15sm2185865wrq.97.2019.11.07.06.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 06:15:46 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Olaf Hering <olaf@aepfle.de>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        "open list\:Hyper-V CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] tools/hv: async name resolution in kvp_daemon
In-Reply-To: <20191107144850.37587edb.olaf@aepfle.de>
References: <20191024144943.26199-1-olaf@aepfle.de> <874kzfbybk.fsf@vitty.brq.redhat.com> <20191107144850.37587edb.olaf@aepfle.de>
Date:   Thu, 07 Nov 2019 15:15:45 +0100
Message-ID: <87zhh7ai26.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
X-MC-Unique: CS--QH8TO4G51UrR0F6FgA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Olaf Hering <olaf@aepfle.de> writes:

> Am Thu, 07 Nov 2019 14:39:11 +0100
> schrieb Vitaly Kuznetsov <vkuznets@redhat.com>:
>
>> Olaf Hering <olaf@aepfle.de> writes:
>
>> Is it only EAI_AGAIN or do you see any other return values which justify
>> the retry? I'm afraid that in case of a e.g. non-existing hostname we'll
>> be infinitely looping with EAI_FAIL.
>
> I currently do not have a setup that reproduces the failure.
> I think if this thread loops forever, so be it.
>
> The report I have shows "getaddrinfo failed: 0xfffffffe Name or service n=
ot known" on the host side.
> And that went away within the VM once "networking was fixed", whatever th=
is means.
> But hv_kvp_daemon would report the error string forever.

Looping forever with a permanent error is pretty unusual...

>
>> > +=09pthread_detach(t); =20
>> I think this should be complemented with pthread_cancel/pthread_join
>> before exiting main().
>
> If the thread is detached, it is exactly that: detached. Why do you think=
 the main thread should wait for the detached thread?

Ah, my bad: you actually can't join a detached thread, scratch my
comment.

--=20
Vitaly

