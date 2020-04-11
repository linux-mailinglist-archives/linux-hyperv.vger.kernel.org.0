Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03F451A528E
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Apr 2020 17:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgDKPDQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 11 Apr 2020 11:03:16 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:45324 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgDKPDQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 11 Apr 2020 11:03:16 -0400
Received: by mail-pg1-f173.google.com with SMTP id w11so2280177pga.12;
        Sat, 11 Apr 2020 08:03:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=qrw5ccj1107Sl/MixdSfnj6RmUvu7x9K5P5QyzMfY1U=;
        b=DHhZgcdDHtlHnnSdX18akCuC4OCR40JyF+9q9t7xcdfdRMlQRqwcd5ey5GxDD+6muO
         INzigi3vIvYojaS1BX7A1vhuEfIXGRjHvlddUsQxtkqTisu1CNRj6OrOEkhlhphJwTdz
         gdI683aDqZe8bdcdq0iMJ6FdLUQ8WEXsFp3jfSB6lMU0uUsiU0CLRHvMZgVd2YKwiTux
         3DCGB4z4WJF2WYgmg2+cSwj4lfkelmolEAY5MWvFFE8+OfidxN23E6ywxnDlZvta8plQ
         mHEEJkHJbyf1aszIL8Gk3OdU2IhCfU73OLnL6kgVSo0gmT5JM+AHxhWDAj0sx2Xq0BRR
         ajlQ==
X-Gm-Message-State: AGi0PubH4oM1hDtQM/A6I8Icllg0NXjS/HI0muak/dcOoEASNrHwjYOT
        80kvRI32qPVD05hXEPM3+RtgcPEN
X-Google-Smtp-Source: APiQypKYeASoR0r1ntMGv9XOX326Jb/OK8oLwRgtvxhOJAJ7Ods42ZfM2so70Hatqswc3+92q/5tjA==
X-Received: by 2002:a63:dd09:: with SMTP id t9mr8920579pgg.432.1586617394899;
        Sat, 11 Apr 2020 08:03:14 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:c9fa:49a8:1701:9c75? ([2601:647:4000:d7:c9fa:49a8:1701:9c75])
        by smtp.gmail.com with ESMTPSA id mq6sm4601106pjb.38.2020.04.11.08.03.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Apr 2020 08:03:13 -0700 (PDT)
Subject: Re: SCSI low level driver: how to prevent I/O upon hibernation?
To:     Dexuan Cui <decui@microsoft.com>, Ming Lei <tom.leiming@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Long Li <longli@microsoft.com>, vkuznets <vkuznets@redhat.com>,
        Michael Kelley <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Olaf Hering <olaf@aepfle.de>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <HK0P153MB0273A1B109CE3A33F0984D34BFDE0@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
 <CACVXFVO5Ni531JO+62CW4pV2y6gT98_8G=jiCJCZoqjkUBmo9Q@mail.gmail.com>
 <HK0P153MB027320771C7A000B85BF3B97BFDF0@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
From:   Bart Van Assche <bvanassche@acm.org>
Autocrypt: addr=bvanassche@acm.org; prefer-encrypt=mutual; keydata=
 mQENBFSOu4oBCADcRWxVUvkkvRmmwTwIjIJvZOu6wNm+dz5AF4z0FHW2KNZL3oheO3P8UZWr
 LQOrCfRcK8e/sIs2Y2D3Lg/SL7qqbMehGEYcJptu6mKkywBfoYbtBkVoJ/jQsi2H0vBiiCOy
 fmxMHIPcYxaJdXxrOG2UO4B60Y/BzE6OrPDT44w4cZA9DH5xialliWU447Bts8TJNa3lZKS1
 AvW1ZklbvJfAJJAwzDih35LxU2fcWbmhPa7EO2DCv/LM1B10GBB/oQB5kvlq4aA2PSIWkqz4
 3SI5kCPSsygD6wKnbRsvNn2mIACva6VHdm62A7xel5dJRfpQjXj2snd1F/YNoNc66UUTABEB
 AAG0JEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPokBOQQTAQIAIwUCVI67
 igIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEHFcPTXFzhAJ8QkH/1AdXblKL65M
 Y1Zk1bYKnkAb4a98LxCPm/pJBilvci6boefwlBDZ2NZuuYWYgyrehMB5H+q+Kq4P0IBbTqTa
 jTPAANn62A6jwJ0FnCn6YaM9TZQjM1F7LoDX3v+oAkaoXuq0dQ4hnxQNu792bi6QyVdZUvKc
 macVFVgfK9n04mL7RzjO3f+X4midKt/s+G+IPr4DGlrq+WH27eDbpUR3aYRk8EgbgGKvQFdD
 CEBFJi+5ZKOArmJVBSk21RHDpqyz6Vit3rjep7c1SN8s7NhVi9cjkKmMDM7KYhXkWc10lKx2
 RTkFI30rkDm4U+JpdAd2+tP3tjGf9AyGGinpzE2XY1K5AQ0EVI67igEIAKiSyd0nECrgz+H5
 PcFDGYQpGDMTl8MOPCKw/F3diXPuj2eql4xSbAdbUCJzk2ETif5s3twT2ER8cUTEVOaCEUY3
 eOiaFgQ+nGLx4BXqqGewikPJCe+UBjFnH1m2/IFn4T9jPZkV8xlkKmDUqMK5EV9n3eQLkn5g
 lco+FepTtmbkSCCjd91EfThVbNYpVQ5ZjdBCXN66CKyJDMJ85HVr5rmXG/nqriTh6cv1l1Js
 T7AFvvPjUPknS6d+BETMhTkbGzoyS+sywEsQAgA+BMCxBH4LvUmHYhpS+W6CiZ3ZMxjO8Hgc
 ++w1mLeRUvda3i4/U8wDT3SWuHcB3DWlcppECLkAEQEAAYkBHwQYAQIACQUCVI67igIbDAAK
 CRBxXD01xc4QCZ4dB/0QrnEasxjM0PGeXK5hcZMT9Eo998alUfn5XU0RQDYdwp6/kMEXMdmT
 oH0F0xB3SQ8WVSXA9rrc4EBvZruWQ+5/zjVrhhfUAx12CzL4oQ9Ro2k45daYaonKTANYG22y
 //x8dLe2Fv1By4SKGhmzwH87uXxbTJAUxiWIi1np0z3/RDnoVyfmfbbL1DY7zf2hYXLLzsJR
 mSsED/1nlJ9Oq5fALdNEPgDyPUerqHxcmIub+pF0AzJoYHK5punqpqfGmqPbjxrJLPJfHVKy
 goMj5DlBMoYqEgpbwdUYkH6QdizJJCur4icy8GUNbisFYABeoJ91pnD4IGei3MTdvINSZI5e
Message-ID: <55ba8004-55fa-4bd6-59e9-c21f9c0e75bc@acm.org>
Date:   Sat, 11 Apr 2020 08:03:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <HK0P153MB027320771C7A000B85BF3B97BFDF0@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 2020-04-10 23:01, Dexuan Cui wrote:
> Please let me know if the change to scsi_device_set_state() is OK.

Hadn't Ming Lei already root-caused this issue for you? From his e-mail:
"So you can't free related vmbus ringbuffer cause BLK_MQ_REQ_PREEMPT
request is still to be handled."

Please follow that advice.

Thanks,

Bart.
