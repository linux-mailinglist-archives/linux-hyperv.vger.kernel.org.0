Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFDA1AC232
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Apr 2020 15:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895104AbgDPNTd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 16 Apr 2020 09:19:33 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42200 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2895099AbgDPNTa (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 16 Apr 2020 09:19:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587043169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JEw6kLXze2haywQeiOQ5EDcQGVtvnQE9Y5SKoxEqeF4=;
        b=Rh6O1UYrYcNgSauWUkyVPxRbvOn4dl+j+KWvJ5PltFkShhwLevsdzw91R0L+df55FXyoV1
        ZVGAaAfrYVPnNCB+iKVTVHCd9BQ52p1ZDmSLkYb++C/EWIQ2LPZ4DEc/tkFgr5+WZvCLaV
        c2Ne53V530qRxdFdR0uFQ4UKD+uXWXM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-PYJkYMslPHGoKCJrria5jQ-1; Thu, 16 Apr 2020 09:19:24 -0400
X-MC-Unique: PYJkYMslPHGoKCJrria5jQ-1
Received: by mail-wm1-f71.google.com with SMTP id h6so1393247wmi.7
        for <linux-hyperv@vger.kernel.org>; Thu, 16 Apr 2020 06:19:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=JEw6kLXze2haywQeiOQ5EDcQGVtvnQE9Y5SKoxEqeF4=;
        b=eMI3JRLV9wFNPxrlTaZcR+uOOLKesVXo0pv8Fv00WmoWHDu14qaIhs0zhoo+74CleC
         n+gCKzwenDOS2jkNNMoCAjTaMQ4RsSd8vS1HyJTjNKjdonrP9dTr7KrdhVZH8/+habFm
         P2UxCFfT4Lk4bMksSxOXV0umYMOt9YNx68bpNIdOz6oP1xX5P6fWuMn2NU6yOZFqpwBX
         GiD17QQqYQ+Zz1XgGdr8WdnEf1ckhqfqZpou0cXFRI4gO4en8B6AGjPZif3+Uywe+p4M
         iErPX08bQgWmgOhNucH1LX7b7glva3fLra2KsnBQ/8gTkTn965I8/U5kCK49BxKgN/f+
         ybZw==
X-Gm-Message-State: AGi0PublhmBAUMP1jWDg+MQCxi0EdSSj1+DvdEpFQyt3K64IrY1fwvCU
        O15IlsKLDzGM6Dqm2+w6PlXVRTjkIdrHa9kbX8F8YvzOXo0mblwGCXgG+eumMVG/rj1jpIhSASL
        4R8RV+XtxOIJ6lDmDQpGx6D6O
X-Received: by 2002:a5d:6841:: with SMTP id o1mr34561677wrw.412.1587043163235;
        Thu, 16 Apr 2020 06:19:23 -0700 (PDT)
X-Google-Smtp-Source: APiQypKQ4lbeOSyR1XshDuR8EWNRydxPgHwd1xV9n6dwTTctMb3egplsxM/9j9R5WhC8asCM1+2Ung==
X-Received: by 2002:a5d:6841:: with SMTP id o1mr34561653wrw.412.1587043163015;
        Thu, 16 Apr 2020 06:19:23 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id 74sm15403795wrk.30.2020.04.16.06.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 06:19:22 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Jon Doron <arilou@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v10 7/7] KVM: selftests: update hyperv_cpuid with SynDBG tests
In-Reply-To: <20200416110540.GK7606@jondnuc>
References: <20200324074341.1770081-1-arilou@gmail.com> <20200324074341.1770081-8-arilou@gmail.com> <87d09286mx.fsf@vitty.brq.redhat.com> <20200416110540.GK7606@jondnuc>
Date:   Thu, 16 Apr 2020 15:19:21 +0200
Message-ID: <87v9lzva92.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Jon Doron <arilou@gmail.com> writes:

> Did this patchset make it into the merge window?
>

My crystal ball tells me we should ask Paolo (To:) ;-)

-- 
Vitaly

