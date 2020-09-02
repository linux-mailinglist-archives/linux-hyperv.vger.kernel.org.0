Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0EDF25A987
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Sep 2020 12:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgIBKe2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Sep 2020 06:34:28 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34865 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726183AbgIBKeX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Sep 2020 06:34:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599042858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6YbE9ocgSEbs212dC/3NaXleeyro7z5HehKfcKWSbBA=;
        b=XVXOkaSVsrnNFtOndEZ2c8dnN33SWL70w3zWnnT6iWpQC40Pr0+LLXI7Ad5FaLH/iAjmGg
        ehFU7B4myou/LvOAqSaCYQHVFqqKri2o+WTcEWFZpUqjUZmCnc/7kmkfBOEHShfLBKmdgG
        OfvJEsM6y+gsZOhYdAbcrPUkQtpYBaI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-dkXnKf3wPDepSFTCuxDaxQ-1; Wed, 02 Sep 2020 06:34:15 -0400
X-MC-Unique: dkXnKf3wPDepSFTCuxDaxQ-1
Received: by mail-ej1-f71.google.com with SMTP id p21so1947332ejj.18
        for <linux-hyperv@vger.kernel.org>; Wed, 02 Sep 2020 03:34:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=6YbE9ocgSEbs212dC/3NaXleeyro7z5HehKfcKWSbBA=;
        b=nQ3ufYMoqgWsSDN25/WWNLjCSNHSthLktxvbCYiog0G8f55f6qWz6MBQrD0WCbvDii
         Qby0VkoEzIx1/rItPq1lKiQ+/mvZFZGKFpRBQ/fCTMiBCwupa/7MVDmI3mF2fx5dWIvA
         gGDFHFFENS8PO2xMK7z70vFOhCWfXPiLfOr0526szBiNpJDSNi2V1yYDyAF4C9uXFt9X
         6khvFSU/h6zATHntPK6xz68UlSDTMQ7JOZpKQCSF9PMWKbRZGJ7qvbCAgHk2FaARI0Rs
         tLHLzoZyep7h0zfohLpJ67uaXmi9aBGpWJkkh7p0vffpa+ew3hv18kQ+7Ll3YNkWyXAb
         j0uA==
X-Gm-Message-State: AOAM530XvY+QzpWnNWJnb3tzkTOhXRSbXtl6WOvh+3xTk0HQj2zGKpIx
        VwnDNu4CDddy+oVgfJvt46emPY7IhufIB83EoPAXeT5KY8Jp8Ww+C57Ca9cIYXWQhmIDpnPtDZM
        MUv/boh6XrU8ENtONTdifh4r0
X-Received: by 2002:a50:8e52:: with SMTP id 18mr5951888edx.28.1599042853960;
        Wed, 02 Sep 2020 03:34:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyfvB2OEfbLYHiQ0iuRWX5RnGHRm0NO4ryqac7O6KtUoD1XTteJLc6sk4G2sRZytr3cwXHFA==
X-Received: by 2002:a50:8e52:: with SMTP id 18mr5951872edx.28.1599042853725;
        Wed, 02 Sep 2020 03:34:13 -0700 (PDT)
Received: from ?IPv6:2003:c2:2f12:bb04:81d3:a22d:db7e:2eac? (p200300c22f12bb0481d3a22ddb7e2eac.dip0.t-ipconnect.de. [2003:c2:2f12:bb04:81d3:a22d:db7e:2eac])
        by smtp.gmail.com with ESMTPSA id x1sm3831470ejc.119.2020.09.02.03.34.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2020 03:34:13 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v1 4/5] xen/balloon: try to merge system ram resources
Date:   Wed, 2 Sep 2020 12:34:12 +0200
Message-Id: <24371321-8A12-4EBD-864C-A2B50E886BF7@redhat.com>
References: <226413fc-ef25-59bd-772f-79012fda0ee3@suse.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        =?utf-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
        Julien Grall <julien@xen.org>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Baoquan He <bhe@redhat.com>,
        Wei Yang <richardw.yang@linux.intel.com>
In-Reply-To: <226413fc-ef25-59bd-772f-79012fda0ee3@suse.com>
To:     =?utf-8?Q?J=C3=BCrgen_Gro=C3=9F?= <jgross@suse.com>
X-Mailer: iPhone Mail (17G68)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> Am 02.09.2020 um 12:15 schrieb J=C3=BCrgen Gro=C3=9F <jgross@suse.com>:
>=20
> =EF=BB=BFOn 21.08.20 12:34, David Hildenbrand wrote:
>> Let's reuse the new mechanism to merge system ram resources below the
>> root. We are the only one hotplugging system ram (e.g., DIMMs don't apply=
),
>> so this is safe to be used.
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>> Cc: Juergen Gross <jgross@suse.com>
>> Cc: Stefano Stabellini <sstabellini@kernel.org>
>> Cc: Roger Pau Monn=C3=A9 <roger.pau@citrix.com>
>> Cc: Julien Grall <julien@xen.org>
>> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>> Cc: Baoquan He <bhe@redhat.com>
>> Cc: Wei Yang <richardw.yang@linux.intel.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  drivers/xen/balloon.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>> diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
>> index 37ffccda8bb87..5ec73f752b8a7 100644
>> --- a/drivers/xen/balloon.c
>> +++ b/drivers/xen/balloon.c
>> @@ -338,6 +338,10 @@ static enum bp_state reserve_additional_memory(void)=

>>      if (rc) {
>>          pr_warn("Cannot add additional memory (%i)\n", rc);
>>          goto err;
>> +    } else {
>> +        resource =3D NULL;
>> +        /* Try to reduce the number of system ram resources. */
>> +        merge_system_ram_resources(&iomem_resource);
>>      }
>=20
> I don't see the need for setting resource to NULL and to use an "else"
> clause here.
>=20

I set it to NULL because the pointer may be stale after that call - to avoid=
 future bugs. But I can drop it.

Ack to the =E2=80=9Eelse=E2=80=9C case.

Thanks for having a look!

>=20
> Juergen
>=20

